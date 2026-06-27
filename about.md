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
<p>{{ experience.period }}{% if experience.location %} - {{ experience.location }}{% endif %}</p>
{% endif %}
{% if experience.projects %}
{% for project in experience.projects %}
<h4>{{ project.name }}{% if project.period %} ({{ project.period }}){% endif %}</h4>
<ul>
	{% for highlight in project.highlights %}
	<li>{{ highlight }}</li>
	{% endfor %}
</ul>
{% if project.stack %}
<p><strong>Stack:</strong> {{ project.stack | join: ", " }}</p>
{% endif %}
{% endfor %}
{% elsif experience.highlights %}
<ul>
	{% for highlight in experience.highlights %}
	<li>{{ highlight }}</li>
	{% endfor %}
</ul>
{% endif %}
{% endfor %}

<h2>Selected Projects</h2>

<ul>
	{% for project in site.data.projects %}
	<li>
		{% if project.url %}<a href="{{ project.url }}">{{ project.name }}</a>{% else %}<strong>{{ project.name }}</strong>{% endif %}{% if project.summary %} - {{ project.summary }}{% endif %}
	</li>
	{% endfor %}
</ul>

<h2>Certifications</h2>

<ul>
	{% for certification in site.data.certifications %}
	<li>{{ certification.name }}{% if certification.issuer %}, {{ certification.issuer }}{% endif %}{% if certification.issued %} ({{ certification.issued }}){% endif %}</li>
	{% endfor %}
</ul>

<h2>Recognition & Community</h2>

<ul>
	{% for recognition in site.data.recognitions %}
	<li>
		<strong>{{ recognition.title }}</strong>{% if recognition.event %}, {{ recognition.event }}{% endif %}{% if recognition.description %} - {{ recognition.description }}{% endif %}
	</li>
	{% endfor %}
</ul>

<h2>Education</h2>

<ul>
	{% for education in site.data.education %}
	<li>{{ education.degree }}, {{ education.institution }}{% if education.period %} ({{ education.period }}){% endif %}</li>
	{% endfor %}
</ul>
