{% macro generatefullname(firstname, lastname) -%}
    concat({{ firstname }}, ' ', {{ lastname }})
{% endmacro -%}