{% extends 'display_priority.tpl' %}


{% block in_prompt %}
{% endblock in_prompt %}

{% block output_prompt %}
{%- endblock output_prompt %}

{% block input %}
```
{%- if 'magics_language' in cell.metadata  -%}
    {{ cell.metadata.magics_language}}
{%- elif 'name' in nb.metadata.get('language_info', {}) -%}
    {{ nb.metadata.language_info.name }}
{%- else -%} 
    plaintext
{%- endif %}
{{ cell.source}}
```
{% endblock input %}

{% block error %}
{{ super() }}
{% endblock error %}

{% block traceback_line %}
{{ line | indent | strip_ansi }}
{% endblock traceback_line %}

{% block execute_result %}

{% block data_priority scoped %}
{{ super() }}
{% endblock %}
{% endblock execute_result %}

{% block stream %}
{{ output.text | indent }}
{% endblock stream %}

{% block data_svg %}
    {% if "filenames" in output.metadata %}
![svg]({{ output.metadata.filenames['image/svg+xml'] | path2url }})
    {% else %}
![svg](data:image/svg;base64,{{ output.data['image/svg+xml'] }})
    {% endif %}
{% endblock data_svg %}

{% block data_png %}
    {% if "filenames" in output.metadata %}
![png]({{ output.metadata.filenames['image/png'] | path2url }})
    {% else %}
![png](data:image/png;base64,{{ output.data['image/png'] }})
    {% endif %}
{% endblock data_png %}

{% block data_jpg %}
    {% if "filenames" in output.metadata %}
![jpeg]({{ output.metadata.filenames['image/jpeg'] | path2url }})
    {% else %}
![jpeg](data:image/jpeg;base64,{{ output.data['image/jpeg'] }})
    {% endif %}
{% endblock data_jpg %}

{% block data_latex scoped %}
<div class="output_latex output_subarea {{ extra_class }}">
{{ output.data['text/latex'] }}
</div>
{%- endblock data_latex %}

{% block data_html scoped %}
{{ output.data['text/html'] }}
{% endblock data_html %}

{% block data_markdown scoped %}
{{ output.data['text/markdown'] }}
{% endblock data_markdown %}

{% block data_text scoped %}
{{ output.data['text/plain'] | indent }}
{% endblock data_text %}

{% block markdowncell scoped %}
{{ cell.source }}
{% endblock markdowncell %}

{% block unknowncell scoped %}
unknown type  {{ cell.type }}
{% endblock unknowncell %}