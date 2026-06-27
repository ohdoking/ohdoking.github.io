---
title: About
layout: page
---
![Profile Image]({{ site.url }}/{{ site.picture }})

{% assign profile = site.data.profile %}

{% if profile.headline %}
<p>{{ profile.headline }}</p>
{% endif %}

{% for paragraph in profile.summary %}
<p>{{ paragraph }}</p>
{% endfor %}

<h2>Skills</h2>

{% for skill_group in profile.skills %}
<h3>{{ skill_group.group }}</h3>
<ul class="skill-list">
	{% for skill in skill_group.items %}
	<li>{{ skill }}</li>
	{% endfor %}
</ul>
{% endfor %}

<h2>Experience</h2>

{% for experience in site.data.experience %}
<h3>{{ experience.role }}{% if experience.organization %} - {{ experience.organization }}{% endif %}</h3>
{% if experience.period %}
<p>{{ experience.period }}</p>
{% endif %}
<ul>
	{% for highlight in experience.highlights %}
	<li>{{ highlight }}</li>
	{% endfor %}
</ul>
{% endfor %}

<h2>Personal Projects</h2>

<ul>
	{% for project in site.data.projects %}
	<li>
		<a href="{{ project.url }}">{{ project.name }}</a>{% if project.summary %} - {{ project.summary }}{% endif %}
	</li>
	{% endfor %}
</ul>
