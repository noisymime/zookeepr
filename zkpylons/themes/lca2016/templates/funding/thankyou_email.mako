From: ${ h.lca_info['event_name'] } <${ h.lca_info['contact_email'] }>
To: ${ c.person.firstname } ${ c.person.lastname } <${ c.person.email_address }>
Subject: Confirmation of your ${ c.funding.type.name } funding request for ${ h.lca_info['event_name'] }

Dear ${ c.person.firstname },

Thank you for submitting a ${ c.funding.type.name } request for ${ h.lca_info['event_name'] }.

If you have any queries about your ${ c.funding.type.name } funding request,
please email ${ h.lca_info['contact_email'] } to submit a ticket to our Request Tracker (RT)
Or, you may email diversity@lcabythebay.org.au to contact our Diversity Officer.

Should you need to update the details of this request, please use the following
URL:

  http://${ h.host_name() }/funding


The ${ h.event_name() } team
http://${ h.host_name() }/contact
