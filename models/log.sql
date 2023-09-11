SELECT
    DISTINCT
        event_name AS tipo,
        event_timestamp AS datahora,
        event_schema AS schema,
        event_model AS modelo,
        event_user AS usuario,
        event_target AS event_target
FROM
    {{target.schema}}_meta.dbt_audit_log