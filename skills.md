---
title: Skills
layout: page
description: Backend, cloud, DevOps, data, messaging, and AI engineering skills used across production systems and product development.
---

<h1 class="title">Skills</h1>

<div class="skills-grid">
	{% assign profile = site.data.profile %}
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
