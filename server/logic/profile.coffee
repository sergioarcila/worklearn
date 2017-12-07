###############################################
@get_profile_name_by_user_id = (user_id, short = false, plus_id=true) ->
	p_f =
		owner_id: user_id
	profile = Profiles.findOne p_f

	return get_profile_name(profile, short, plus_id)


###############################################
@get_profile_name = (profile, short = false, plus_id=true) ->
	if !profile
		return "unknown"

	name = (profile.given_name ? "Learner") + " "

	if not short
		name += (profile.middle_name ? "") + " "
		name += profile.family_name ? ""

	if plus_id
		name += "("+String(profile.owner_id)+")"

	return name


###############################################
@get_user_mail = (user) ->
	address = "unknown"

	if user.emails
		mail = user.emails[0]
		if mail
			address = mail.address

	return address


###############################################
@gen_profile = (user, occupation) ->
	if not occupation
		occupation = "learner"

	profile = Profiles.findOne user._id

	if profile
		return profile._id

	profile =
		mail_notifications: "yes"
		notification_cycle: "day"
		last_notification: new Date()
		has_occupation: true
		template_id: "profile"
		occupation: occupation
		requested: 0
		provided: 0
		owner_id: user._id
		avatar: "data:image/png;base64,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"

	user = Meteor.users.findOne user._id

	if not user
		msg = "User id error: " + user._id
		log_event msg, event_db, event_imp

	if user.profile
		profile.given_name = user.profile.given_name
		profile.family_name = user.profile.family_name
		profile.name = "Profile for " + user.profile.given_name
	else
		profile.name = "Profile for unknown"

	msg = "User profile created: " + get_user_mail user + " (" + user._id + ")"
	log_event msg, event_db, event_imp

	return store_document_unprotected Profiles, profile


