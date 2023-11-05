SELECT
    DISTINCT
        event_name AS type_event,
        event_timestamp AS datahora,
        event_schema AS schema,
        event_model AS models,
        event_user AS users,
        event_target AS event_target
FROM
    {{target.schema}}_meta.dbt_audit_log