<h1>Feed report</h1>

<ul>
  <%= for url <- urls do  %>
    <li>
      <a href="<%= url %>">
        <%= url %>
      </a>
    </li>
  <% end %>
</ul>