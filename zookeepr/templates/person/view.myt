<h2>
% if c.person.handle:
% 	if c.person.handle.endswith("s"):
<% c.person.handle |h %>'
%	else:
<% c.person.handle |h %>'s
%	#endif
% #endif
profile</h2>

<div class="boxed">

<p>
   <b>Email:</b>
    <% c.person.email_address | h %><br />
</p>

<p>
   <b>Display name:</b>
    <% c.person.handle | h %><br />
</p>

<p>
   <b>First name:</b>
    <% c.person.firstname | h %><br />
</p>

<p>
   <b>Last name:</b>
    <% c.person.lastname | h %><br />
</p>
</div>

<p>
   <b>Phone:</b>
<% c.person.phone %><br />
</p>

<p>
<b>Mobile:</b>
<% c.person.mobile %>
</p>

#<h2>proposals</h2>

#<table>

#% for s in c.person.proposals:
#<tr>
#<td><% h.link_to(s.title, h.url_for(controller='/proposal', action='view', id=s.id)) %></td>
#<td><% s.abstract %></td>
#<td>
#%	if s.proposal_type:
#<% s.proposal_type.name %>
#%
#</td>
#<td>
#% 	if s.attachment:
#has attachment
#%
#</td>
#% #endfor
#</table>

<hr />

#% if c.can_edit:
#<% h.link_to('Edit', url=h.url(action='edit',id=c.person.get_unique())) %> |
#% #end if
#<% h.link_to('Back', url=h.url(action='index')) %>

<%method title>
Profile -
% if c.person.handle is not None:
<% c.person.handle |h %> -
%
<& PARENT:title &>
</%method>
