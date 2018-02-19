<h1>Twitter report</h1>

<ul>
  <%= for tweet <- tweets do  %>
    <li>
      <strong>
        <%= tweet.user %> :
      </strong>
      <br> 
      <%= tweet.text %>
      <br>
      <a href="<%= tweet.url %>">
        <%= tweet.url %>
      </a>
    </li>
  <% end %>
</ul>