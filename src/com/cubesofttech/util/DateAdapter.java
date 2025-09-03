package com.cubesofttech.util;

import com.google.gson.*;
import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateAdapter implements JsonSerializer<Date>, JsonDeserializer<Date> {

    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

    // แปลง Date → JSON String
    @Override
    public JsonElement serialize(Date src, Type typeOfSrc, JsonSerializationContext context) {
        return new JsonPrimitive(dateFormat.format(src));
    }

    // แปลง JSON String → Date
    @Override
    public Date deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
            throws JsonParseException {
        try {
            return dateFormat.parse(json.getAsString());
        } catch (Exception e) {
            throw new JsonParseException("Invalid date format", e);
        }
    }
}