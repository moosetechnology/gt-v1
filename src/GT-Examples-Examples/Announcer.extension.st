Extension { #name : #Announcer }

{ #category : #'*GT-Examples-Examples' }
Announcer class >> gtExampleEmptyAnnouncer [
	<gtExample>
	<label: 'Empty Announcer'>
	
	^ self new
]

{ #category : #'*GT-Examples-Examples' }
Announcer class >> gtExampleSystemAnnouncer [
	<gtExample>
	<label: 'System Announcer'>
	
	^ SystemAnnouncer uniqueInstance
]
