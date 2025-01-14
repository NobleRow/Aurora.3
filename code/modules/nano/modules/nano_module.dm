/datum/nano_module
	var/name
	var/datum/host
	var/available_to_ai = TRUE
	var/datum/topic_manager/topic_manager

/datum/nano_module/New(var/datum/host, var/topic_manager)
	..()
	src.host = host
	src.topic_manager = topic_manager

/datum/nano_module/ui_host()
	return host ? host.ui_host() : src

/datum/nano_module/proc/can_still_topic(var/datum/ui_state/state = default_state)
	return CanUseTopic(usr, state) == STATUS_INTERACTIVE

/datum/nano_module/proc/check_eye(var/mob/user)
	return -1

/datum/nano_module/proc/check_access(var/mob/user, var/access)
	if(!access)
		return 1

	if(!istype(user))
		return 0

	var/obj/item/card/id/I = user.GetIdCard()
	if(!I)
		return 0

	if(access in I.access)
		return 1

	return 0

/datum/nano_module/Topic(href, href_list)
	if(topic_manager && topic_manager.Topic(href, href_list))
		return TRUE
	. = ..()

/datum/nano_module/nano_host()
	return host ? host : src

/datum/nano_module/proc/get_host_z()
	return GET_Z(nano_host())

/datum/proc/initial_data()
	return list()

/datum/proc/update_layout()
	return FALSE

/datum/proc/nano_host()
	return src
