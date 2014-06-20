Extension { #name : #Announcer }

{ #category : #'*GT-InspectorExtensions-Core' }
Announcer >> gtInspectorAnnouncementsIn: composite [
	<gtInspectorPresentationOrder: 40>
	| recordedAnnouncements |
	recordedAnnouncements := CollectionValueHolder value: OrderedCollection new.
	self when: Announcement do: [ :ann | recordedAnnouncements addFirst: ann ].
	composite list
		title: 'Announcements';
		display: [ recordedAnnouncements value ];
		showOnly: 50;
		format: #gtDisplayString;
		updateOn: Announcement from: recordedAnnouncements announcer;
		act: [ :table | 
			recordedAnnouncements := OrderedCollection new.
			table update ] 
			icon: GLMUIThemeExtraIcons glamorousCancel 
			entitled: 'Reset'
]

{ #category : #'*GT-InspectorExtensions-Core' }
Announcer >> gtInspectorSubscriptionsIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite table
		title: 'Subscriptions';
		display: [ self subscriptions glmSubscriptions ];
		when: [ self numberOfSubscriptions isZero not ];
		column: 'Subscriber' evaluated: [ :each | each subscriber asString ];
		column: 'Announcement' evaluated: [ :each | each announcementClass name ];
		column: 'Kind' evaluated: [ :each | each class name ];
		act: [ :table | 
			self subscriptions reset.
			table update ] icon: GLMUIThemeExtraIcons glamorousCancel entitled: 'Reset';
		selectionAct: [ :table | 
			self subscriptions remove: table selection.
			table update ] entitled: 'Remove subscription'
]
