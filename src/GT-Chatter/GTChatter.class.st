Class {
	#name : #GTChatter,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'clientId',
		'conversations',
		'proxy',
		'filter',
		'subscribed',
		'onlineUsers',
		'onlineUsersUpdater'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GT-Chatter-Model'
}

{ #category : #accessing }
GTChatter class >> me [
	^ self uniqueInstance
]

{ #category : #ui }
GTChatter class >> open [ 
	^ self uniqueInstance open
]

{ #category : #ui }
GTChatter class >> openNamed: aClientId [ 
	^ self new clientId: aClientId; open
]

{ #category : #accessing }
GTChatter class >> reset [
	uniqueInstance ifNotNil: [ :aChatter |
		uniqueInstance := nil.
		aChatter stop ]
]

{ #category : #protocol }
GTChatter class >> sendText: aMessage to: aClientId [
	^ self uniqueInstance sendText: aMessage to: aClientId
]

{ #category : #accessing }
GTChatter class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #adding }
GTChatter >> addOnlineUser: aGTCOnlineClient [ 
	^ self onlineUsers addOnlineUser: aGTCOnlineClient
]

{ #category : #accessing }
GTChatter >> announcer [
	^ announcer ifNil: [ 
		announcer := Announcer new.
		self subscribeForLocalAnnouncements.
		announcer ].
]

{ #category : #accessing }
GTChatter >> announcer: anObject [
	self unsubscribeFromLocalAnnoucementsOn: announcer.
	announcer := anObject.
	self subscribeForLocalAnnouncements.
]

{ #category : #protocol }
GTChatter >> answerAsOnline: aGTCWhoIsOnline [
	self onlineUsers receivedWhoIsOnline: aGTCWhoIsOnline.
	self notifyAsOnline.
]

{ #category : #accessing }
GTChatter >> clientId [
	^ clientId ifNil: [ clientId := Author fullName ]
]

{ #category : #accessing }
GTChatter >> clientId: anObject [
	clientId := anObject
]

{ #category : #accessing }
GTChatter >> conversations [
	^ conversations ifNil: [ 
			conversations := GTConversations new
										announcer: self announcer;
										yourself ]
]

{ #category : #accessing }
GTChatter >> conversations: anObject [
	conversations := anObject.
	conversations announcer: self announcer.
]

{ #category : #'instance creation' }
GTChatter >> newRemoteProxy [
	^ RAProxy new
			url: GTCSettings url;
			connectIfNotConnected;
			yourself
]

{ #category : #protocol }
GTChatter >> notifyAsOnline [
	^ self proxy announce: (GTCOnlineClient new from: self clientId; yourself)
]

{ #category : #accessing }
GTChatter >> numberOfConversations [
	^ self conversations numberOfConversations
]

{ #category : #accessing }
GTChatter >> numberOfMessages [
	^ self conversations numberOfMessages
]

{ #category : #accessing }
GTChatter >> onlineUsers [
	^ onlineUsers ifNil: [ onlineUsers := GTCOnlineUsers new ]
]

{ #category : #accessing }
GTChatter >> onlineUsersUpdater [
	^ onlineUsersUpdater ifNil: [ onlineUsersUpdater := GTCOnlineUsersUpdater new chatter: self; yourself ]
]

{ #category : #ui }
GTChatter >> open [
	self start.
	^ GTChatterUI new
			chatterModel: self;
			open.
]

{ #category : #accessing }
GTChatter >> proxy [
	^ proxy ifNil: [ self proxy: self newRemoteProxy. proxy ]
]

{ #category : #accessing }
GTChatter >> proxy: anObject [
	| shouldSubscribe |
	shouldSubscribe := proxy notNil.
	proxy ifNotNil: [ :aProxy | self unsubscribeFromRemoteAnnoucements ].
	proxy := anObject.
	shouldSubscribe ifTrue: [ self subscribeForRemoteAnnoucements ].
]

{ #category : #protocol }
GTChatter >> receive: aMessage [ 
	^ self conversations 
				receive: aMessage asReceivedMessage 
				from: aMessage from
]

{ #category : #ui }
GTChatter >> selectRecipient [
	| dialog recipient |
	dialog := ListDialogWindow new
		getList: [ :r | self onlineUsers recent select: [ :e | r search: e asString ] ];
		displayBlock: [ :e | e ];
		title: 'Select a user' translated;
		yourself.
	recipient := dialog chooseFromOwner: World.
	^ recipient
]

{ #category : #protocol }
GTChatter >> send: anAnnouncement [
	| message |
	anAnnouncement updateFromChatter: self.
	message := self sent: anAnnouncement.
	self proxy announce: anAnnouncement.
]

{ #category : #protocol }
GTChatter >> sendText: aTextOrString to: aClientId [
	| anAnnouncement |
	anAnnouncement := GTCTextMessage new 
										from: self clientId; 
										to: aClientId; 
										message: aTextOrString;
										yourself.
	self send: anAnnouncement.
]

{ #category : #private }
GTChatter >> sent: aRemoteAnnouncement [ 
	^ self conversations sent: aRemoteAnnouncement asSentMessage
]

{ #category : #private }
GTChatter >> sent: aMessage to: aClientId [ 
	^ self conversations 
				sent: aMessage asSentMessage 
				to: aClientId
]

{ #category : #protocol }
GTChatter >> setLocalProxy [
	"Useful for test cases."
	self proxy: Announcer new.
]

{ #category : #protocol }
GTChatter >> setRemoteProxy [
	"Useful for test cases."
	self proxy: self newRemoteProxy.
]

{ #category : #protocol }
GTChatter >> start [
	self subscribeForRemoteAnnoucements.
	self notifyAsOnline.
	self onlineUsersUpdater start.
]

{ #category : #protocol }
GTChatter >> stop [
	self onlineUsersUpdater stop.
	self unsubscribeFromRemoteAnnoucements.
	
]

{ #category : #private }
GTChatter >> subscribeForLocalAnnouncements [
	self announcer 
		when: GTSendTextMessage 
			do: [ :announcement | 
				self sendText: announcement message to: announcement clientId.
				announcement messageSent ]
			for: self.
]

{ #category : #private }
GTChatter >> subscribeForRemoteAnnoucements [
	self subscribed ifTrue: [ ^ self ].
	subscribed := true.
	self proxy 
		when: GTCAddressedMessage 
			do: [ :announcement | 
				(announcement isFor: self clientId) 
					ifTrue: [ self receive: announcement ] ]
			for: self;
		when: GTCOnlineClient 
			do: [ :announcement | 
				 (announcement isFrom: self clientId)
					ifFalse: [ self addOnlineUser: announcement ] ]
			for: self;
		when: GTCWhoIsOnline 
			do: [ :announcement | self answerAsOnline: announcement ]
			for: self.
]

{ #category : #accessing }
GTChatter >> subscribed [
	^ subscribed ifNil: [ subscribed := false ]
]

{ #category : #private }
GTChatter >> unsubscribeFromLocalAnnoucementsOn: anAnnouncerOrNil [
	anAnnouncerOrNil ifNotNil: [ anAnnouncerOrNil unsubscribe: self ]
]

{ #category : #private }
GTChatter >> unsubscribeFromRemoteAnnoucements [
	self proxy unsubscribe: self.
	subscribed := false.
]

{ #category : #protocol }
GTChatter >> whoIsOnline [
	self proxy announce: (GTCWhoIsOnline new 
									from: self clientId;
									yourself)
]
