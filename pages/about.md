---
layout: page
title: About
permalink: /about/
weight: 4
---

# **About Me**
---
Hi I am **{{ site.author.name }}** :wave:,<br>
I'am a Tunisian :tunisia: Data Scientist who live in France :fr:.
I love coding :octocat:, the art of making memories tangible (Photography) :camera: and practicing sport (mainly weight trainig) :muscle:.
I will be happy to participate in any opensource project or data related ones :computer:.

# **Skills**
---
<div class="row">
{% include about/skills.html title="Programming Skills" source=site.data.programming-skills %}
{% include about/skills.html title="Functional skills" source=site.data.functional-skills %}
</div>


# **Experience**
---
<div class="row">
{% include about/timeline.html %}
</div>


# **Certifications**
---
<div class="row">
{% include about/certifications.html %}
</div>