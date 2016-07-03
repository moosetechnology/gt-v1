Extension { #name : #Announcer }

{ #category : #'*GT-Examples-Core' }
Announcer >> unsubscribe: anAnnouncementClass thoroughlyFor: aSubscriber [
	^ registry protected: [
		registry subscriptions removeAllSuchThat: [ :subscription | 
			subscription subscriber class == aSubscriber class " class !!! "
			 and: [ subscription announcementClass == anAnnouncementClass ] ] ]

]

{ #category : #'*GT-Examples-Core' }
Announcer >> unsubscribeThoroughly: aSubscriber [
	^ registry protected: [
		registry subscriptions removeAllSuchThat: [ :subscription | 
			subscription subscriber class == aSubscriber class " class !!! " ] ]

]
