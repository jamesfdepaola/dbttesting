{#
{% macro CountryIsUSA(country) -%}
    {% if {{ country }} == 'United States' -%}
        "True"
    {% elif  {{ country }} == 'United States of America' -%}
        "True"
    {% else -%}
        "False"
    {% endif -%}
{% endmacro -%}

#}

{% macro CountryIsUSA(country_col) -%}
    if(
        lower(trim({{ country_col }})) in ('united states', 'united states of america', 'usa', 'us'),
        true,
        false
    )
{%- endmacro %}