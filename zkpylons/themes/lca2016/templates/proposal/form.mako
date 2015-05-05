<%page args="editing" />
    <div class="form-group">
      <label for="proposaltitle" class="col-sm-2 control-label">Title</label>
      <div class="input-group">
% if editing:
        <input type="text" id="proposaltitle" class="form-control" placeholder="${ c.title }" name="proposal.title" required />
% else:
        <input type="text" id="proposaltitle" class="form-control" placeholder="Talk title" name="proposal.title" required/>
%endif
        <span class="input-group-addon" id="basic-addon2">required</span>
      </div>
    </div>

    
      <label for="proposaltype" class="col-sm-2 control-label">The type of your proposal. </label>
% for st in c.proposal_types:
<%
   if st.name == 'Miniconf':
       continue
%>
    <div class="input-group">
      <label>
        <input type="radio" name="proposal.type" id="proposal.type_${ st.id }" value="${ st.id }">
        ${ st.name }
      </label>
    </div>
% endfor

    <div class="form-group"> 
      <div class="textarea">
        <label for="proposalabstract" class="col-sm-0 control-label">Public Abstract</label>
        <textarea class="form-control" id="proposalabstract" placeholder="This will appear in the conference programme. You will have an opportunity to update it once the proposal is accepted, but it should reasonably reflect what you will be presenting, and in any case it will appear as-is on the website in the draft programme. Up to about 500 words." name="proposal.abstract" rows="10" cols="70" required></textarea>
      </div>
    </div>

    <div class="form-group"> 
      <div class="textarea">
        <label for="proposalpriveate_abstract" class="col-sm-0 control-label">Private Abstract</label>
        <textarea class="form-control" id="proposalprivate_abstract" placeholder="This will only be shown to organisers and reviewers. You should provide any details about your proposal that you don't want to be public here." name="proposal.private_abstract" rows="10" required></textarea>
      </div>
    </div>

    <div class="form-group"> 
      <div class="textarea">
        <label for="proposaltechnical_requirements" class="col-sm-0 control-label">Technical Requirements</label>
        <textarea class="form-control" id="proposalprivate_abstract" placeholder="Speakers will be provided with: Internet access, power, projector, audio.  If you require anything in addition, please list your technical requirements here.  Such as: a static IP address, A/V equipment or will be demonstrating security-related techniques on the conference network." name="proposal.technical_requirements" rows="10"></textarea>
      </div>
    </div>

    <div class="form-group">
      <label for="proposalaudience" class="col-sm-2 control-label">Target audience</label>
          <div class="col-sm-8">
% for at in c.target_audiences:
            <div class="radio">
              <label>
                <input type="radio" name="proposal.audience" id="proposal.audience_${ at.id }" value="${ at.id }">
                ${ at.name }
              </label>
            </div>
% endfor
          </div>
    </div>

    <div class="form-group">
      <label for="proposalproject" class="col-sm-2 control-label">Project</label>
      <div class="col-sm-10">
% if editing:
        <input type="text" id="proposalproject" class="form-control" placeholder="${ c.title }" name="proposal.project" />
% else:
        <input type="text" id="proposalproject" class="form-control" placeholder="The name of the project you will be talking about" name="proposal.project" />
%endif
      </div>
    </div>

    <div class="form-group">
      <label for="proposalurl" class="col-sm-2 control-label">Project URL (Optional)</label>
      <div class="col-sm-10">
% if editing:
        <input type="text" id="proposalurl" class="form-control" placeholder="${ c.title }" name="proposal.url" />
% else:
        <input type="text" id="proposalurl" class="form-control" placeholder="www" name="proposal.url" />
%endif
      </div>
    </div>

    <p class="label"><label for="proposal.abstract_video_url">Video abstract:</label></p>
    <p class="note">URL for a short "elevator pitch" (20s - 3min) video about your proposal, your project or yourself (eg: YouTube link).</p>
    <p class="entries">${ h.text('proposal.abstract_video_url', size=60) }</p>

% if not editing:
    <p class="label"><label for="attachment">Attach file:</label></p>
    <p class="note">Any additional information, image, etc. You can attach and delete more files later by editing this submission.</p>
    <p class="entries">${ h.file('attachment', size=50) }</p>
% else:
    <p class="entries">${ h.link_to('Add an attachment', url=h.url_for(action='attach')) } ${ h.hidden('attachment', size=60) }<span class="note">You can attach multiple files by following this link.</span></p>
% endif

% if h.lca_info['cfp_hide_assistance_options'] is 'no':
    <h2>Travel &amp; Accommodation Assistance</h2>
    <p class="note" style="margin-top: 0em">linux.conf.au has some funds available to provide travel and accommodation for selected speakers, both from the local region and internationally.</p>

    <p class="note" style="margin-top: 0em">Please note that <b>free admission</b> to the full conference is awarded to all primary speakers.</p>

    <p class="label"><span class="mandatory">*</span><label>Travel assistance:</label></p>
    <p class="entries">
<% onclick = "document.getElementById('travelwarning').style.display = 'none';" %>
% for ta in c.travel_assistance_types:
    <label>${ h.radio('proposal.travel_assistance', ta.id, None,
    onclick=onclick) }
    ${ ta.name |h }</label><br>
    <% onclick = "document.getElementById('travelwarning').style.display = '';" %>
% endfor
    </p>

    <p id="travelwarning" class="warningbox" style="display: none">WARNING: We have a limited travel budget and requesting travel assistance <b>affects     your chances of acceptance</b>.</p>

    <p class="label"><span class="mandatory">*</span><label>Accommodation assistance:</label></p>
    <p class="entries">
% for aa in c.accommodation_assistance_types:
    <label>${ h.radio('proposal.accommodation_assistance', aa.id) }
    ${ aa.name |h }</label><br>
% endfor
    </p>
% else:
    ${ h.hidden('proposal.travel_assistance') }
    ${ h.hidden('proposal.accommodation_assistance') }
% endif

% if h.lca_info['cfp_hide_assistance_options'] is 'by_email': 
    <h2>Travel &amp; Accommodation Assistance</h2>
    <p class="note" style="margin-top: 0em">Please note that <b>free admission</b> to the full conference is offered to all speakers.</p>
    <p class="note" style="margin-top: 0em">Travel &amp; accommodation assistance <em>may</em> be available in circumstances where it is absolutely necessary. To find out more please e-mail <em>${ h.lca_info['contact_email'] }</em>.</p>
% endif


    <h2>About yourself</h2>

    <p><em>Note: These are common for all your proposals: presentations and tutorials.</em></p>

    <p>If two or more people are presenting together, this information should for the primary speaker; mention the other speakers in the Abstract, eg. "(with Bob Vaxhacker and Eve Duo)".</p>

    <p class="label"><span class="mandatory">*</span><span class="publishable">&#8224;</span><label for="person.name">Speaker's name:</label></p>
    ${ h.hidden(name="person_to_edit", value="replaced by htmlfill.render(...)") }
    <p class="note">(Can't be changed here.)</p>
    <p class="entries">${ h.text('name', value="replaced by htmlfill.render(...)", size=60, disabled=True) }</p>

    <p class="label"><span class="mandatory">*</span><label for="person.mobile">Speaker's mobile phone:</label></p>
    <p class="note">The conference team will need this to contact you during the conference week. If you don't have one, or do not wish to provide it, then enter NONE in this field</p>
    <p class="entries">${ h.text('person.mobile', size=60) }</p>

    <p class="label"><span class="publishable">&#8224;</span><label for="person.url">Speaker's homepage:</label></p>
    <p class="note">Your homepage.</p>
    <p class="entries">${ h.text('person.url', size=60) }</p>

    <p class="label"><span class="mandatory">*</span><span class="publishable">&#8224;</span><label for="person.bio">Biography:</label></p>
    <p class="note">This will appear on the conference website and in the programme.  Please write in the third person, eg "Alice is a Moblin hacker...", 150-200 words.</p>
    <p class="entries">${ h.textarea('person.bio', cols="70", rows="6") }</p>

    <p class="label"><span class="mandatory">*</span><label for="person.experience">Relevant experience:</label></p>
    <p class="note">Have you had any experience presenting elsewhere? If so, we'd like to know. Anything you put here will only be seen by the organisers and reviewers; use it to convince them why they should accept your proposal.</p>
    <p class="entries">${ h.textarea('person.experience', cols="70", rows="6") }</p>

    <p class="entries">
      ${ h.checkbox('proposal.video_release') }
      <label for="proposal.video_release">I allow ${ h.lca_info["event_parent_organisation"] } to
      release any recordings of my presentations, tutorials and minconfs under the <a href="${ h.lca_info["media_license_url"] }">${ h.lca_info["media_license_name"] }</a></label>
    </p>

    <p class="entries">
      ${ h.checkbox('proposal.slides_release') }
      <label for="proposal.slides_release">I allow ${ h.lca_info["event_parent_organisation"] } to release any other material (such as slides) from my presentations, tutorials and minconfs under the <a href="${ h.lca_info["media_license_url"] }">${ h.lca_info["media_license_name"] }</a></label>
    </p>


    <p>&nbsp;</p>
    <p class="note"><span class="mandatory">*</span> - Mandatory field</p>
    <p class="note"><span class="publishable">&#8224;</span> - Will be published (if your proposal is accepted)</p>

    <p>We reserve the right to forward proposals (accepted or not) to the miniconf organisers for possible inclusion in the miniconf programme.</p>
