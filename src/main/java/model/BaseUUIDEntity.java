package model;

import java.io.Serializable;
import java.util.Objects;
import java.util.UUID;

abstract class BaseUUIDEntity implements Serializable {
    private UUID uuid;

    protected BaseUUIDEntity() {
    }

    protected BaseUUIDEntity(UUID uuid) {
        setUuid(uuid);
    }

    protected BaseUUIDEntity(String uuid) {
        setUuid(UUID.fromString(uuid));
    }

    public UUID getUuid() {
        return uuid;
    }

    protected void setUuid(UUID uuid) {
        Objects.requireNonNull(uuid);
        this.uuid = uuid;
    }

    public static UUID generateUuid(){
        return UUID.randomUUID();
    }
    public static UUID generateUuid(String uuid){
        return UUID.fromString(uuid);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        BaseUUIDEntity that = (BaseUUIDEntity) o;
        return uuid.equals(that.uuid);
    }

    @Override
    public int hashCode() {
        return uuid.hashCode();
    }
}
