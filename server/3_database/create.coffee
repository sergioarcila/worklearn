#######################################################
#
# Created by Markus
#
#######################################################

#######################################################
@store_document_unprotected = (collection, document, owner)->
	document["created"] = new Date()
	document["modified"] = new Date()

	id = collection.insert document
	item = collection.findOne id

	if not owner
		return id

	user = Meteor.users.findOne owner._id

	gen_admission collection._name, item, user, OWNER
	return id

