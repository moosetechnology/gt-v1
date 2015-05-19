Class {
	#name : #GTAConfiguration,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #accessing }
GTAConfiguration class >> developerUUIDs [
	"
	GTSpotterEventRecorderSettings ensureComputerID.
	GTSpotterEventRecorderSettings uniqueInstance computerUUID.
	"
	^ #( 	'58d42da6-c993-4ad1-8624-5fd628793610' 
			'8c7d33b4-1025-42b3-8dc4-4a2bb32c5a42'
			'4483f704-6909-45d7-9367-869a5850c3e8'
			'52fe7c39-9c98-4fa7-a883-a8b2cabe84db'
			'69202c73-b32f-4968-aaf1-0666d421ea57'
			'0cd69f50-ad08-8c47-84ec-329e2210a2f2'
		)
]

{ #category : #testing }
GTAConfiguration class >> isDeveloper: anUUID [
	^ self developerUUIDs includes: anUUID asString
]

{ #category : #api }
GTAConfiguration class >> loadBookmarks: aGTAComputers [
	^ GTABookmarks from: self savedBookmarks computers: aGTAComputers
]

{ #category : #api }
GTAConfiguration class >> saveBookmarks: aGTABookmarks [
	| paths methodSource |
	paths := aGTABookmarks collect: [ :each | each path ] as: Array.
	methodSource := String streamContents: [ :aStream |
		aStream
			nextPutAll: 'savedBookmarks'; cr; 
			tab; nextPutAll: '"Automatically created by class method #saveBookmarks."'; cr;
			tab; nextPutAll: '^ '.
		paths storeOn: aStream. 			
	 ].
	self class compile: methodSource classified: 'stored bookmarks'.
]

{ #category : #'stored bookmarks' }
GTAConfiguration class >> savedBookmarks [
	"Automatically created by class method #saveBookmarks."
	^ ((Array new: 9) at: 1 put: ((Array new: 6) at: 1 put: GTASessionBookmark; at: 2 put: '29d8c44d-c6da-4026-bf49-c3b0c25625db'; at: 3 put: (DateAndTime basicNew instVarAt: 1 put: 72594; instVarAt: 2 put: (Duration seconds: 7200 nanoSeconds: 0); instVarAt: 3 put: 2457117; instVarAt: 4 put: 0; yourself); at: 4 put: 'History and calculator results'; at: 5 put: (DateAndTime basicNew instVarAt: 1 put: 70290; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457156; instVarAt: 4 put: 682694000; yourself); at: 6 put: false; yourself); at: 2 put: ((Array new: 6) at: 1 put: GTASessionBookmark; at: 2 put: '5ce39222-e2e9-441a-b877-d3ca84be5d75'; at: 3 put: (DateAndTime basicNew instVarAt: 1 put: 70406; instVarAt: 2 put: (Duration seconds: 3600 nanoSeconds: 0); instVarAt: 3 put: 2457099; instVarAt: 4 put: 0; yourself); at: 4 put: 'Remove this kind of sessions, because user only opens and closes Spotter.
No reason to keep it.'; at: 5 put: (DateAndTime basicNew instVarAt: 1 put: 49356; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457157; instVarAt: 4 put: 347933000; yourself); at: 6 put: false; yourself); at: 3 put: ((Array new: 5) at: 1 put: GTAComputerBookmark; at: 2 put: '5ce39222-e2e9-441a-b877-d3ca84be5d75'; at: 3 put: 'We should remove sessions with unknown elements in dive-in, in act-on, etc.'; at: 4 put: (DateAndTime basicNew instVarAt: 1 put: 55511; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457157; instVarAt: 4 put: 197500000; yourself); at: 5 put: false; yourself); at: 4 put: ((Array new: 5) at: 1 put: GTAComputerBookmark; at: 2 put: '8cafe0a2-c35e-43c8-a945-3fb323f3bfb8'; at: 3 put: 'It uses dives-in and several categories.'; at: 4 put: (DateAndTime basicNew instVarAt: 1 put: 56543; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457157; instVarAt: 4 put: 84485000; yourself); at: 5 put: false; yourself); at: 5 put: ((Array new: 6) at: 1 put: GTASessionBookmark; at: 2 put: 'b077896a-af9a-4364-b59a-8fab094f8f98'; at: 3 put: (DateAndTime basicNew instVarAt: 1 put: 58242; instVarAt: 2 put: (Duration seconds: -25200 nanoSeconds: 0); instVarAt: 3 put: 2457145; instVarAt: 4 put: 873372000; yourself); at: 4 put: 'Remove such sessions. It is only opened and closed.'; at: 5 put: (DateAndTime basicNew instVarAt: 1 put: 56747; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457157; instVarAt: 4 put: 332268000; yourself); at: 6 put: true; yourself); at: 6 put: ((Array new: 6) at: 1 put: GTASessionBookmark; at: 2 put: '29d8c44d-c6da-4026-bf49-c3b0c25625db'; at: 3 put: (DateAndTime basicNew instVarAt: 1 put: 46260; instVarAt: 2 put: (Duration seconds: 3600 nanoSeconds: 0); instVarAt: 3 put: 2457101; instVarAt: 4 put: 0; yourself); at: 4 put: 'Remove it, there are only preview on/off.'; at: 5 put: (DateAndTime basicNew instVarAt: 1 put: 66326; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457157; instVarAt: 4 put: 834319000; yourself); at: 6 put: true; yourself); at: 7 put: ((Array new: 6) at: 1 put: GTASessionBookmark; at: 2 put: '29d8c44d-c6da-4026-bf49-c3b0c25625db'; at: 3 put: (DateAndTime basicNew instVarAt: 1 put: 46295; instVarAt: 2 put: (Duration seconds: 3600 nanoSeconds: 0); instVarAt: 3 put: 2457101; instVarAt: 4 put: 0; yourself); at: 4 put: 'Remove it, there are only preview on/off.'; at: 5 put: (DateAndTime basicNew instVarAt: 1 put: 66379; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457157; instVarAt: 4 put: 289678000; yourself); at: 6 put: true; yourself); at: 8 put: ((Array new: 6) at: 1 put: GTASessionBookmark; at: 2 put: '29d8c44d-c6da-4026-bf49-c3b0c25625db'; at: 3 put: (DateAndTime basicNew instVarAt: 1 put: 58917; instVarAt: 2 put: (Duration seconds: 3600 nanoSeconds: 0); instVarAt: 3 put: 2457103; instVarAt: 4 put: 0; yourself); at: 4 put: 'It is a simplest example of using spotter: It reuse the first item in category called History.'; at: 5 put: (DateAndTime basicNew instVarAt: 1 put: 66651; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457157; instVarAt: 4 put: 665799000; yourself); at: 6 put: false; yourself); at: 9 put: ((Array new: 5) at: 1 put: GTAComputerBookmark; at: 2 put: '29d8c44d-c6da-4026-bf49-c3b0c25625db'; at: 3 put: 'A lot of categories are browsed.'; at: 4 put: (DateAndTime basicNew instVarAt: 1 put: 67093; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457157; instVarAt: 4 put: 55077000; yourself); at: 5 put: false; yourself); yourself)
]
