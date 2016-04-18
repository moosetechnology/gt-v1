Extension { #name : #WeakSubscriptionBuilder }

{ #category : #'*GT-Inspector-Examples-Core' }
WeakSubscriptionBuilder >> unsubscribe: anAnnouncementClass thoroughlyfor: aSubscriber [
	announcer unsubscribe: anAnnouncementClass thoroughlyfor: aSubscriber
]
