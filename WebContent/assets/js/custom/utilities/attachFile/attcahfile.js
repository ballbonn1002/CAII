async function processAndRemoveWhiteBg(file, maxWidth = 1280, maxHeight = 1280, quality = 0.8) {
    if (!file) throw new Error("No file provided");

    // 1. บีบอัดไฟล์ภาพก่อน (เรียกฟังก์ชัน compressImage เดิมของคุณ)
    const compressedFile = await compressImage(file, maxWidth, maxHeight, quality);

    // 2. ประมวลผลลบพื้นหลังขาวด้วย Canvas
    return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = function(event) {
            const img = new Image();
            img.onload = function() {
                const canvas = document.createElement('canvas');
                const ctx = canvas.getContext('2d');
                canvas.width = img.width;
                canvas.height = img.height;
                ctx.drawImage(img, 0, 0);

                const image = ctx.getImageData(0, 0, canvas.width, canvas.height);
                const imageData = image.data;

                // วนลูปตรวจสอบพิกเซลสีขาว (R, G, B > 240) แล้วปรับ Alpha เป็น 0 (โปร่งใส)
                for (let i = 0; i < imageData.length; i += 4) {
                    const r = imageData[i];
                    const g = imageData[i + 1];
                    const b = imageData[i + 2];
                    if (r > 240 && g > 240 && b > 240) {
                        imageData[i + 3] = 0; 
                    }
                }
                ctx.putImageData(image, 0, 0);

                // แปลง Canvas กลับเป็น Blob รูปแบบ PNG
                canvas.toBlob(function(blob) {
                    const originalName = compressedFile.name;
                    const dotIdx = originalName.lastIndexOf('.');
                    const nameOnly = dotIdx > 0 ? originalName.substring(0, dotIdx) : originalName;
                    const finalFileName = nameOnly + ".png";

                    // คืนค่าไฟล์ใหม่ที่พร้อมใช้งานออกไป
                    const finalFile = new File([blob], finalFileName, { type: "image/png" });
                    resolve(finalFile);
                }, 'image/png');
            };
            img.onerror = reject;
            img.src = event.target.result;
        };
        reader.onerror = reject;
        reader.readAsDataURL(compressedFile);
    });
}
