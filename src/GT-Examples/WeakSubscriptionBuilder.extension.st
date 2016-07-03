Extension { #name : #WeakSubscriptionBuilder }

{ #category : #'*GT-Examples-Core' }
WeakSubscriptionBuilder >> unsubscribe: anAnnouncementClass thoroughlyFor: aSubscriber [
	announcer unsubscribe: anAnnouncementClass thoroughlyFor: aSubscriber
]
