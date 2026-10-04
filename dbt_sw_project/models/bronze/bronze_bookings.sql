{{
  config(
    materialized = 'incremental',
    unique_key = 'BOOKING_ID',
    )
}}

SELECT * FROM {{ source('stage', 'bookings') }}

{% if is_incremental() %}
  where CREATED_AT >= coalesce((select max(CREATED_AT) from {{ this }}), '1900-01-01')
{% endif %}