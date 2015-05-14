Trait {
	#name : #TGTABookmarkIt,
	#category : #'GT-Spotter-EventRecorder-Analysis-Traits'
}

{ #category : #api }
TGTABookmarkIt >> bookmarkIt [
	self explicitRequirement
]

{ #category : #accessing }
TGTABookmarkIt >> bookmarks [
	self explicitRequirement
]

{ #category : #'gt-inspector-extension' }
TGTABookmarkIt >> gtInspectorActionBookmarkIt [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ self bookmarkIt ];
		icon: Smalltalk ui icons glamorousBookmark;
		title: 'Bookmark It'
]

{ #category : #'gt-inspector-extension' }
TGTABookmarkIt >> gtInspectorBookmarksIn: composite [
	<gtInspectorPresentationOrder: 9>
	composite tabulator 
		when: [ self isBookmarked ];
		title: 'Bookmarks';
		with: [ :browser | 
			browser
				row: #list;
				row: #description.
			browser transmit 
				to: #list;
				andShow: [ :c |
					c list 
						display: [ self relatedBookmarks ];
						format: [ :aBookmark | 
							GTObjectPrinter new asTruncatedTextFrom: aBookmark description asString ];
						updateOn: GTACollectionAnnouncement 
							from: [ :aEventCollection | 
										aEventCollection bookmarks announcer ];
						selectionAct: [ :list :relatedBookmarks |
							self removeBookmark: list selection.
							list update ]
							entitled: 'Remove bookmark' ].
			browser transmit
				to: #description;
				from: #list port: #selection;
				andShow: [ :c |
					c rubricText
						display: #description;
						act: [ :port :bookmark | 
								bookmark description: port text asString.
								self bookmarks save.
								port pane browser panes do: #update ] 
							on: $s
							entitled: 'Save' ]
		] 
]

{ #category : #testing }
TGTABookmarkIt >> isBookmarked [
	^ self bookmarks hasRelatedTo: self
]

{ #category : #accessing }
TGTABookmarkIt >> relatedBookmarks [
	^ self bookmarks relatedTo: self
]

{ #category : #api }
TGTABookmarkIt >> removeBookmark: aBookmark [
	self bookmarks 
		removeBookmark: aBookmark;
		save.
]
