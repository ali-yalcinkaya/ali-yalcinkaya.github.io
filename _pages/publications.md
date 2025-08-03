---
layout: collection
title: "Publications"
collection: publications
permalink: /publications/
author_profile: true
---


<ul>
{% for pub in site.data.publications %}
  <li>
    <strong>{{ pub.title }}</strong> ({{ pub.year }})  
    {% if pub.venue %} <em>{{ pub.venue }}</em> {% endif %}  
    <a href="{{ pub.link }}" target="_blank">View</a>
  </li>
{% endfor %}
</ul>
