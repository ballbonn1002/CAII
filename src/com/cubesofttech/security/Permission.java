/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cubesofttech.security;


import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTag;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.log4j.Logger;

/**
 * Generated tag handler class.
 * @author  weerawatp
 * @version
 */

public class Permission extends BodyTagSupport {
    private static Logger log = Logger.getLogger(Permission.class);

    public int doStartTag() throws JspException {
        return BodyTag.EVAL_BODY_BUFFERED;
    }

    public void setObject(String object){
        setValue("object", object);
    }

    public int doAfterBody() throws JspException {
        JspWriter out = bodyContent.getEnclosingWriter();
        String text = bodyContent.getString();
        int index = text.indexOf('>') + 1;
        int lastIndex = text.lastIndexOf('<');
        int isButton = text.indexOf("type=\"button\"");
        int isSubmit = text.indexOf("type=\"submit\"");
        int isImage = text.indexOf("type=\"image\"");

        String realText = "";

        if (index<lastIndex)
            realText = text.substring(index,lastIndex);

        HttpSession session = pageContext.getSession();
        Set props = (Set) session.getAttribute("userAuthority");

        try {
            String permission = (String) getValue("object");
            if (props != null && props.contains(permission)) {
                out.print(text);
            }
            else {
                out.print("");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return SKIP_BODY;
    }


}