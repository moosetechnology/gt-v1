Extension { #name : #AbstractEvent }

{ #category : #'*gt-tools' }
AbstractEvent classSide >> handles: anAnnouncementClass [
	^ anAnnouncementClass isKindOf: self
]
