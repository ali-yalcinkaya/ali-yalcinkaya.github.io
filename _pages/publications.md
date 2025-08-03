---
layout: page
title: "Publications"
permalink: /publications/
---

<ul>
{% for pub in site.data.publications %}
  <li>
    <strong>{{ pub.title }}</strong> ({{ pub.year }})
    <a href="{{ pub.link }}" target="_blank">View</a>
  </li>
{% endfor %}
</ul>
