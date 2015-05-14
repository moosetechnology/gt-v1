Class {
	#name : #GTABookmarks,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #'instance creation' }
GTABookmarks class >> from: aCollection computers: aCollection2 [ 
	^ (self new: aCollection size + 10)
			from: aCollection computers: aCollection2;
			yourself
]

{ #category : #adding }
GTABookmarks >> addSession: aGTASession description: aString [ 
	^ self add: (GTASessionBookmark new item: aGTASession; description: aString; yourself)
]

{ #category : #initialization }
GTABookmarks >> from: aCollection computers: aGTAComputers [
	aCollection do: [ :eachBookmarkPath | | bookmark |
		bookmark := eachBookmarkPath first new
							from: eachBookmarkPath computers: aGTAComputers;
							yourself.
		self add: bookmark.
	]
]

{ #category : #testing }
GTABookmarks >> hasRelatedTo: anObject [ 
	^ self anySatisfy: [ :eachBookmark | eachBookmark isRelatedTo: anObject ]
]

{ #category : #enumerating }
GTABookmarks >> relatedTo: anObject [ 
	^ (self select: [ :eachBookmark | eachBookmark isRelatedTo: anObject ]) as: OrderedCollection
]

{ #category : #storing }
GTABookmarks >> save [
	GTAConfiguration saveBookmarks: self
]
