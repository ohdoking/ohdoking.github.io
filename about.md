---
title: About
layout: page
description: About Dokeun Oh, a backend engineer in Berlin building reliable cloud platforms, distributed services, and practical AI systems.
---
![Profile Image]({{ site.url }}/{{ site.picture }})

{% assign profile = site.data.profile %}

<section class="about-intro">
	{% if profile.headline %}
	<p class="about-intro__eyebrow">{{ profile.headline }}</p>
	{% endif %}
	{% if profile.intro_title %}
	<h1>{{ profile.intro_title }}</h1>
	{% endif %}
	{% for paragraph in profile.summary %}
	<p>{{ paragraph }}</p>
	{% endfor %}
</section>

{% if profile.highlights %}
<section class="about-highlights" aria-label="Profile highlights">
	{% for highlight in profile.highlights %}
	<div class="about-highlight">
		<strong>{{ highlight.label }}</strong>
		<span>{{ highlight.text }}</span>
	</div>
	{% endfor %}
</section>
{% endif %}

{% if profile.focus %}
<section class="about-focus">
	<h2>What I Focus On</h2>
	<ul>
		{% for item in profile.focus %}
		<li>{{ item }}</li>
		{% endfor %}
	</ul>
</section>
{% endif %}

<section class="profile-tabs" aria-label="Experience and skills">
	<input class="profile-tabs__input" type="radio" name="profile-tabs" id="profile-tab-experience" checked>
	<input class="profile-tabs__input" type="radio" name="profile-tabs" id="profile-tab-skills">

	<div class="profile-tabs__nav" role="tablist" aria-label="Profile sections">
		<label class="profile-tabs__tab profile-tabs__tab--experience" id="profile-tab-experience-label" for="profile-tab-experience" role="tab">Experience</label>
		<label class="profile-tabs__tab profile-tabs__tab--skills" id="profile-tab-skills-label" for="profile-tab-skills" role="tab">Skills</label>
	</div>

	<div class="profile-tabs__panels">
		<section class="profile-tabs__panel profile-tabs__panel--experience" role="tabpanel" aria-labelledby="profile-tab-experience-label">
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
		</section>

		<section class="profile-tabs__panel profile-tabs__panel--skills" role="tabpanel" aria-labelledby="profile-tab-skills-label">
			<div class="skills-grid">
				{% for skill_group in profile.skills %}
				<section class="skill-group">
					<h2>{{ skill_group.group }}</h2>
					<ul class="skill-list">
						{% for skill in skill_group.items %}
						<li>{{ skill }}</li>
						{% endfor %}
					</ul>
				</section>
				{% endfor %}
			</div>
		</section>
	</div>
</section>

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
