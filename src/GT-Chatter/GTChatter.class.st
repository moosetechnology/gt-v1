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
GTChatter class >> send: aMessage to: aClientId [
	^ self uniqueInstance send: aMessage to: aClientId
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
	^ proxy ifNil: [ 
			proxy := RAProxy new.
			self subscribeForAnnoucements.
			proxy url: GTCSettings url.
			proxy connectIfNotConnected.
			proxy ]
]

{ #category : #accessing }
GTChatter >> proxy: anObject [
	| shouldSubscribe |
	shouldSubscribe := proxy notNil.
	proxy ifNotNil: [ :aProxy | self unsubscribeFromAnnoucements ].
	proxy := anObject.
	shouldSubscribe ifTrue: [ self subscribeForAnnoucements ].
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
GTChatter >> send: aMessage [ 
	| aRecipient |
	aRecipient := self selectRecipient.
	aRecipient ifNotNil: [ 
		self send: aMessage to: aRecipient ]
]

{ #category : #protocol }
GTChatter >> send: aMessage to: aClientId [
	| message |
	message := self sent: aMessage to: aClientId.
	self proxy announce: (GTPrivateMessage new 
										from: self clientId; 
										to: aClientId; 
										message: aMessage;
										yourself).
	^ message
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
GTChatter >> start [
	self subscribeForAnnoucements.
	self notifyAsOnline.
	self onlineUsersUpdater start.
]

{ #category : #protocol }
GTChatter >> stop [
	self onlineUsersUpdater stop.
	self unsubscribeFromAnnoucements.
	
]

{ #category : #private }
GTChatter >> subscribeForAnnoucements [
	self subscribed ifTrue: [ ^ self ].
	subscribed := true.
	self proxy 
		when: GTPrivateMessage 
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

{ #category : #private }
GTChatter >> subscribeForLocalAnnouncements [
	self announcer 
		when: GTSendMessage 
			do: [ :announcement | 
				self send: announcement message to: announcement clientId.
				announcement messageSent ]
			for: self.
]

{ #category : #accessing }
GTChatter >> subscribed [
	^ subscribed ifNil: [ subscribed := false ]
]

{ #category : #private }
GTChatter >> unsubscribeFromAnnoucements [
	self proxy unsubscribe: self.
	subscribed := false.
]

{ #category : #private }
GTChatter >> unsubscribeFromLocalAnnoucementsOn: anAnnouncerOrNil [
	anAnnouncerOrNil ifNotNil: [ anAnnouncerOrNil unsubscribe: self ]
]

{ #category : #protocol }
GTChatter >> whoIsOnline [
	self proxy announce: (GTCWhoIsOnline new 
									from: self clientId;
									yourself)
]
