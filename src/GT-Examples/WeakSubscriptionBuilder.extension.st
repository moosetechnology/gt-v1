Extension { #name : #WeakSubscriptionBuilder }

{ #category : #'*GT-Examples-Core' }
WeakSubscriptionBuilder >> unsubscribe: anAnnouncementClass thoroughlyFor: aSubscriber [
	announcer unsubscribe: anAnnouncementClass thoroughlyFor: aSubscriber
]

{ #category : #'*GT-Examples-Core' }
WeakSubscriptionBuilder >> unsubscribeThoroughly: aSubscriber [
	announcer unsubscribeThoroughly: aSubscriber
]
