package com.cubesofttech.model;

import java.io.Serializable;
import java.util.List;

public class AuthorizedGroupView implements Serializable {

    private static final long serialVersionUID = 1L;

    private AuthorizedObjectGroup group;
    private List<AuthorizedObject> objects;

    public AuthorizedGroupView() {
    }

    public AuthorizedObjectGroup getGroup() {
        return group;
    }

    public void setGroup(AuthorizedObjectGroup group) {
        this.group = group;
    }

    public List<AuthorizedObject> getObjects() {
        return objects;
    }

    public void setObjects(List<AuthorizedObject> objects) {
        this.objects = objects;
    }

    @Override
    public String toString() {
        return "AuthorizedGroupView [group=" + group + ", objects=" + objects + "]";
    }
}
