Extension { #name : #Announcer }

{ #category : #'*GT-Inspector-Examples-Core' }
Announcer >> unsubscribe: anAnnouncementClass thoroughlyfor: aSubscriber [
	^ registry protected: [
		registry subscriptions removeAllSuchThat: [ :subscription | 
			subscription subscriber class == aSubscriber class " !!! "
			 and: [ subscription announcementClass == anAnnouncementClass ] ] ]

]

{ #category : #'*GT-Inspector-Examples-Core' }
Announcer >> unsubscribeThoroughly: aSubscriber [
	^ registry protected: [
		registry subscriptions removeAllSuchThat: [ :subscription | 
			subscription subscriber class == aSubscriber class " !!! " ] ]

]
