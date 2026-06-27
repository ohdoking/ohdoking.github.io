---
title: Experience
layout: page
---

<h1 class="title">Experience</h1>

{% for experience in site.data.experience %}
<article class="experience-item">
	<header class="experience-item__header">
		<h2>{{ experience.role }}</h2>
		{% if experience.organization %}
		<p class="experience-item__organization">{{ experience.organization }}</p>
		{% endif %}
		{% if experience.period %}
		<p class="experience-item__meta">{{ experience.period }}{% if experience.location %} - {{ experience.location }}{% endif %}</p>
		{% endif %}
	</header>

	{% if experience.projects %}
	{% for project in experience.projects %}
	<div class="experience-project">
		<h3>{{ project.name }}{% if project.period %} <span>{{ project.period }}</span>{% endif %}</h3>
		<ul>
			{% for highlight in project.highlights %}
			<li>{{ highlight }}</li>
			{% endfor %}
		</ul>
		{% if project.stack %}
		<p class="experience-stack"><strong>Stack:</strong> {{ project.stack | join: ", " }}</p>
		{% endif %}
	</div>
	{% endfor %}
	{% elsif experience.highlights %}
	<ul>
		{% for highlight in experience.highlights %}
		<li>{{ highlight }}</li>
		{% endfor %}
	</ul>
	{% endif %}
</article>
{% endfor %}
