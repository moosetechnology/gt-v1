Class {
	#name : #GTSpotterCandidatesListTest,
	#superclass : #TestCase,
	#instVars : [
		'candidates'
	],
	#category : #'GT-Spotter-Tests'
}

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> addCategories: aCollection [

	aCollection do: [ :each | candidates addProcessor: each ]
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> hasCategories: aCollection [
	|counter|
	candidates processors asArray size = aCollection size ifFalse: [ ^ false ].
	counter := 1.
	candidates processors asArray
		do: [ :each | (each = (aCollection at: counter)) ifFalse: [ ^ false ] . counter := counter + 1].
	^ true
]

{ #category : #running }
GTSpotterCandidatesListTest >> setUp [

	candidates := GTSpotterCandidatesList new.
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testAddCategories [
	|categories|
	categories := { A1. A2. A3 }.
	
	self addCategories: categories.
	self assert: (self hasCategories: categories)
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testAddOneCandidateA1 [
	|link category|
	
	category := candidates addProcessor: A1.
	link := candidates addCandidate: 11 in: A1.
	
	self assert: (link nextLink = link).
	self assert: (link previousLink = link).
	self assert: (candidates head = link).
	self assert: (candidates tail = link).
	self assert: ((category headLink) = link).
	self assert: ((category tailLink) = link).
	
	
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testAddOneCandidateA1A2 [
	|link11 link21 category1 category2|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	link11 := candidates addCandidate: 11 in: A1.
	link21 := candidates addCandidate: 21 in: A2.
	
	self assert: (link11 nextLink = link21).
	self assert: (link11 previousLink = link21).
	
	self assert: (link21 nextLink = link11).
	self assert: (link21 previousLink = link11).
	
	self assert: (candidates head = link11).
	self assert: (candidates tail = link21).
	
	self assert: ((category1 headLink) = link11).
	self assert: ((category1 tailLink) = link11).
	
	self assert: ((category2 headLink) = link21).
	self assert: ((category2 tailLink) = link21).
	
	
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testAddOneCandidateA1A2A3 [
	|link11 link21 link31 category1 category2 category3|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	category3 := candidates addProcessor: A3.
	
	link11 := candidates addCandidate: 11 in: A1.
	link21 := candidates addCandidate: 21 in: A2.
	link31 := candidates addCandidate: 31 in: A3.
	
	self assert: (link11 nextLink = link21).
	self assert: (link11 previousLink = link31).
	
	self assert: (link21 nextLink = link31).
	self assert: (link21 previousLink = link11).
	
	self assert: (link31 nextLink = link11).
	self assert: (link31 previousLink = link21).
		
	self assert: (candidates head = link11).
	self assert: (candidates tail = link31).
	
	self assert: ((category1 headLink) = link11).
	self assert: ((category1 tailLink) = link11).
	
	self assert: ((category2 headLink) = link21).
	self assert: ((category2 tailLink) = link21).
	
	self assert: ((category3 headLink) = link31).
	self assert: ((category3 tailLink) = link31).
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testAddThreeCandidateA1 [
	|link1 link2 link3 category|
	
	category := candidates addProcessor: A1.
	link1 := candidates addCandidate: 11 in: A1.
	link2 := candidates addCandidate: 12 in: A1.
	link3 := candidates addCandidate: 13 in: A1.
	
	self assert: (link1 nextLink = link2).
	self assert: (link1 previousLink = link3).
	
	self assert: (link2 nextLink = link3).
	self assert: (link2 previousLink = link1).
	
	self assert: (link3 nextLink = link1).
	self assert: (link3 previousLink = link2).
	
	self assert: (candidates head = link1).
	self assert: (candidates tail = link3).
	self assert: ((category headLink) = link1).
	self assert: ((category tailLink) = link3).
	
	
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testAddThreeCandidateA1A2 [
	|link11 link12 link13 link21 link22 link23 category1 category2|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	
	link11 := candidates addCandidate: 11 in: A1.
	link12 := candidates addCandidate: 12 in: A1.
	link13 := candidates addCandidate: 13 in: A1.
	link21 := candidates addCandidate: 21 in: A2.
	link22 := candidates addCandidate: 22 in: A2.
	link23 := candidates addCandidate: 23 in: A2.
	
	self assert: (link11 nextLink = link12).
	self assert: (link11 previousLink = link23).
	
	self assert: (link12 nextLink = link13).
	self assert: (link12 previousLink = link11).
	
	self assert: (link13 nextLink = link21).
	self assert: (link13 previousLink = link12).
	
	self assert: (link21 nextLink = link22).
	self assert: (link21 previousLink = link13).
	
	self assert: (link22 nextLink = link23).
	self assert: (link22 previousLink = link21).
	
	self assert: (link23 nextLink = link11).
	self assert: (link23 previousLink = link22).
	
	self assert: (candidates head = link11).
	self assert: (candidates tail = link23).
	
	self assert: ((category1 headLink) = link11).
	self assert: ((category1 tailLink) = link13).
	
	self assert: ((category2 headLink) = link21).
	self assert: ((category2 tailLink) = link23).
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testAddThreeCandidateA1A2A3 [
	|link11 link12 link13 link21 link22 link23 link31 link32 link33 category1 category2 category3|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	category3 := candidates addProcessor: A3.
	
	link11 := candidates addCandidate: 11 in: A1.
	link12 := candidates addCandidate: 12 in: A1.
	link13 := candidates addCandidate: 13 in: A1.
	link21 := candidates addCandidate: 21 in: A2.
	link22 := candidates addCandidate: 22 in: A2.
	link23 := candidates addCandidate: 23 in: A2.
	link31 := candidates addCandidate: 31 in: A3.
	link32 := candidates addCandidate: 32 in: A3.
	link33 := candidates addCandidate: 33 in: A3.
	
	self assert: (link11 nextLink = link12).
	self assert: (link11 previousLink = link33).
	
	self assert: (link12 nextLink = link13).
	self assert: (link12 previousLink = link11).
	
	self assert: (link13 nextLink = link21).
	self assert: (link13 previousLink = link12).
	
	self assert: (link21 nextLink = link22).
	self assert: (link21 previousLink = link13).
	
	self assert: (link22 nextLink = link23).
	self assert: (link22 previousLink = link21).
	
	self assert: (link23 nextLink = link31).
	self assert: (link23 previousLink = link22).
	
	self assert: (link31 nextLink = link32).
	self assert: (link31 previousLink = link23).
	
	self assert: (link32 nextLink = link33).
	self assert: (link32 previousLink = link31).
	
	self assert: (link33 nextLink = link11).
	self assert: (link33 previousLink = link32).
		
	self assert: (candidates head = link11).
	self assert: (candidates tail = link33).
	
	self assert: ((category1 headLink) = link11).
	self assert: ((category1 tailLink) = link13).
	
	self assert: ((category2 headLink) = link21).
	self assert: ((category2 tailLink) = link23).
	
	self assert: ((category3 headLink) = link31).
	self assert: ((category3 tailLink) = link33).
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testAddThreeCandidateA1A2A3Shuffled [
	|link11 link12 link13 link21 link22 link23 link31 link32 link33 category1 category2 category3|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	category3 := candidates addProcessor: A3.
	
	link21 := candidates addCandidate: 21 in: A2.
	link22 := candidates addCandidate: 22 in: A2.
	link11 := candidates addCandidate: 11 in: A1.
	link31 := candidates addCandidate: 31 in: A3.
	link12 := candidates addCandidate: 12 in: A1.
	link32 := candidates addCandidate: 32 in: A3.
	link23 := candidates addCandidate: 23 in: A2.
	link33 := candidates addCandidate: 33 in: A3.
	link13 := candidates addCandidate: 13 in: A1.
	
	self assert: (link11 nextLink = link12).
	self assert: (link11 previousLink = link33).
	
	self assert: (link12 nextLink = link13).
	self assert: (link12 previousLink = link11).
	
	self assert: (link13 nextLink = link21).
	self assert: (link13 previousLink = link12).
	
	self assert: (link21 nextLink = link22).
	self assert: (link21 previousLink = link13).
	
	self assert: (link22 nextLink = link23).
	self assert: (link22 previousLink = link21).
	
	self assert: (link23 nextLink = link31).
	self assert: (link23 previousLink = link22).
	
	self assert: (link31 nextLink = link32).
	self assert: (link31 previousLink = link23).
	
	self assert: (link32 nextLink = link33).
	self assert: (link32 previousLink = link31).
	
	self assert: (link33 nextLink = link11).
	self assert: (link33 previousLink = link32).
		
	self assert: (candidates head = link11).
	self assert: (candidates tail = link33).
	
	self assert: ((category1 headLink) = link11).
	self assert: ((category1 tailLink) = link13).
	
	self assert: ((category2 headLink) = link21).
	self assert: ((category2 tailLink) = link23).
	
	self assert: ((category3 headLink) = link31).
	self assert: ((category3 tailLink) = link33).
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testAddTwoCandidateA1 [
	|link1 link2 category|
	
	category := candidates addProcessor: A1.
	link1 := candidates addCandidate: 11 in: A1.
	link2 := candidates addCandidate: 12 in: A1.
	
	self assert: (link1 nextLink = link2).
	self assert: (link1 previousLink = link2).
	
	self assert: (link2 nextLink = link1).
	self assert: (link2 previousLink = link1).
	
	self assert: (candidates head = link1).
	self assert: (candidates tail = link2).
	self assert: ((category headLink) = link1).
	self assert: ((category tailLink) = link2).
	
	
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testAddTwoCandidateA1A2 [
	|link11 link12 link21 link22 category1 category2|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	
	link11 := candidates addCandidate: 11 in: A1.
	link12 := candidates addCandidate: 12 in: A1.
	link21 := candidates addCandidate: 21 in: A2.
	link22 := candidates addCandidate: 22 in: A2.
	
	self assert: (link11 nextLink = link12).
	self assert: (link11 previousLink = link22).
	
	self assert: (link12 nextLink = link21).
	self assert: (link12 previousLink = link11).
	
	self assert: (link21 nextLink = link22).
	self assert: (link21 previousLink = link12).
	
	self assert: (link22 nextLink = link11).
	self assert: (link22 previousLink = link21).
	
	self assert: (candidates head = link11).
	self assert: (candidates tail = link22).
	
	self assert: ((category1 headLink) = link11).
	self assert: ((category1 tailLink) = link12).
	
	self assert: ((category2 headLink) = link21).
	self assert: ((category2 tailLink) = link22).
	
	
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testAddTwoCandidateA1A2A3 [
	|link11 link12 link21 link22 link31 link32 category1 category2 category3|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	category3 := candidates addProcessor: A3.
	
	link11 := candidates addCandidate: 11 in: A1.
	link12 := candidates addCandidate: 12 in: A1.
	link21 := candidates addCandidate: 21 in: A2.
	link22 := candidates addCandidate: 22 in: A2.
	link31 := candidates addCandidate: 31 in: A3.
	link32 := candidates addCandidate: 32 in: A3.
	
	self assert: (link11 nextLink = link12).
	self assert: (link11 previousLink = link32).
	
	self assert: (link12 nextLink = link21).
	self assert: (link12 previousLink = link11).
	
	self assert: (link21 nextLink = link22).
	self assert: (link21 previousLink = link12).
	
	self assert: (link22 nextLink = link31).
	self assert: (link22 previousLink = link21).
	
	self assert: (link31 nextLink = link32).
	self assert: (link31 previousLink = link22).
	
	self assert: (link32 nextLink = link11).
	self assert: (link32 previousLink = link31).
		
	self assert: (candidates head = link11).
	self assert: (candidates tail = link32).
	
	self assert: ((category1 headLink) = link11).
	self assert: ((category1 tailLink) = link12).
	
	self assert: ((category2 headLink) = link21).
	self assert: ((category2 tailLink) = link22).
	
	self assert: ((category3 headLink) = link31).
	self assert: ((category3 tailLink) = link32).
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testCategoryLinkByCandidateLinkThreeA1A2A3 [
	|link11 link12 link13 link21 link22 link23 link31 link32 link33 category1 category2 category3|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	category3 := candidates addProcessor: A3.
	
	link11 := candidates addCandidate: 11 in: A1.
	link12 := candidates addCandidate: 12 in: A1.
	link13 := candidates addCandidate: 13 in: A1.
	link21 := candidates addCandidate: 21 in: A2.
	link22 := candidates addCandidate: 22 in: A2.
	link23 := candidates addCandidate: 23 in: A2.
	link31 := candidates addCandidate: 31 in: A3.
	link32 := candidates addCandidate: 32 in: A3.
	link33 := candidates addCandidate: 33 in: A3.
	
	self assert: (category1 = (candidates getProcessorLinkByCandidateLink: link11)).
	self assert: (category1 = (candidates getProcessorLinkByCandidateLink: link12)).
	self assert: (category1 = (candidates getProcessorLinkByCandidateLink: link13)).
	
	self assert: (category2 = (candidates getProcessorLinkByCandidateLink: link21)).
	self assert: (category2 = (candidates getProcessorLinkByCandidateLink: link22)).
	self assert: (category2 = (candidates getProcessorLinkByCandidateLink: link23)).
	
	self assert: (category3 = (candidates getProcessorLinkByCandidateLink: link31)).
	self assert: (category3 = (candidates getProcessorLinkByCandidateLink: link32)).
	self assert: (category3 = (candidates getProcessorLinkByCandidateLink: link33)).
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testNextA1A2Category [

	|link11 link12 link13 link21 link22 link23 category1 category2|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	
	link11 := candidates addCandidate: 11 in: A1.
	link12 := candidates addCandidate: 12 in: A1.
	link13 := candidates addCandidate: 13 in: A1.
	link21 := candidates addCandidate: 21 in: A2.
	link22 := candidates addCandidate: 22 in: A2.
	link23 := candidates addCandidate: 23 in: A2.
	
	self assert: (category1 = (candidates nextProcessorLinkOf: category2)).
	self assert: (category2 = (candidates nextProcessorLinkOf: category1)).
	
	
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testNextA1A2EmptyCategory [

	|link11 link12 link13 category1 category2|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	
	link11 := candidates addCandidate: 11 in: A1.
	link12 := candidates addCandidate: 12 in: A1.
	link13 := candidates addCandidate: 13 in: A1.
	
	self assert: (category1 = (candidates nextProcessorLinkOf: category1)).
	self assert: (category1 = (candidates nextProcessorLinkOf: category2)).
	
	
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testNextA1Category [

	|link11 link12 link13 category1 |
	
	category1 := candidates addProcessor: A1.
	
	link11 := candidates addCandidate: 11 in: A1.
	link12 := candidates addCandidate: 12 in: A1.
	link13 := candidates addCandidate: 13 in: A1.
	
	self assert: (category1 = (candidates nextProcessorLinkOf: category1)).
	
	
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testPreviousA1A2Category [

	|link11 link12 link13 link21 link22 link23 category1 category2|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	
	link11 := candidates addCandidate: 11 in: A1.
	link12 := candidates addCandidate: 12 in: A1.
	link13 := candidates addCandidate: 13 in: A1.
	link21 := candidates addCandidate: 21 in: A2.
	link22 := candidates addCandidate: 22 in: A2.
	link23 := candidates addCandidate: 23 in: A2.
	
	self assert: (category1 = (candidates previousProcessorLinkOf: category2)).
	self assert: (category2 = (candidates previousProcessorLinkOf: category1)).
	
	
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testPreviousA1A2EmptyCategory [

	|link11 link12 link13 category1 category2|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	
	link11 := candidates addCandidate: 11 in: A1.
	link12 := candidates addCandidate: 12 in: A1.
	link13 := candidates addCandidate: 13 in: A1.
	
	self assert: (category1 = (candidates previousProcessorLinkOf: category1)).
	self assert: (category1 = (candidates previousProcessorLinkOf: category2)).
	
	
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testPreviousA1Category [

	|link11 link12 link13 category1 |
	
	category1 := candidates addProcessor: A1.
	
	link11 := candidates addCandidate: 11 in: A1.
	link12 := candidates addCandidate: 12 in: A1.
	link13 := candidates addCandidate: 13 in: A1.
	
	self assert: (category1 = (candidates previousProcessorLinkOf: category1)).
	
	
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testRemoveCandidatesA1A2A3FromA1A2A3 [
	|category1 category2 category3|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	category3 := candidates addProcessor: A3.
	
	candidates addCandidate: 11 in: A1.
	candidates addCandidate: 12 in: A1.
	candidates addCandidate: 13 in: A1.
	candidates addCandidate: 21 in: A2.
	candidates addCandidate: 22 in: A2.
	candidates addCandidate: 23 in: A2.
	candidates addCandidate: 31 in: A3.
	candidates addCandidate: 32 in: A3.
	candidates addCandidate: 33 in: A3.
	
	candidates removeAllCandidatesOf: A1.
	candidates removeAllCandidatesOf: A3.
	candidates removeAllCandidatesOf: A2.
			
	self assert: (candidates head = nil).
	self assert: (candidates tail = nil).
	
	self assert: ((category1 headLink) = nil).
	self assert: ((category1 tailLink) = nil).
	
	self assert: ((category2 headLink) = nil).
	self assert: ((category2 tailLink) = nil).
	
	self assert: ((category3 headLink) = nil).
	self assert: ((category3 tailLink) = nil).
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testRemoveCandidatesA1A3FromA1A2A3 [
	|link21 link22 link23 category1 category2 category3|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	category3 := candidates addProcessor: A3.
	
	candidates addCandidate: 11 in: A1.
	candidates addCandidate: 12 in: A1.
	candidates addCandidate: 13 in: A1.
	link21 := candidates addCandidate: 21 in: A2.
	link22 := candidates addCandidate: 22 in: A2.
	link23 := candidates addCandidate: 23 in: A2.
	candidates addCandidate: 31 in: A3.
	candidates addCandidate: 32 in: A3.
	candidates addCandidate: 33 in: A3.
	
	candidates removeAllCandidatesOf: A1.
	candidates removeAllCandidatesOf: A3.
	
	self assert: (link21 nextLink = link22).
	self assert: (link21 previousLink = link23).
	
	self assert: (link22 nextLink = link23).
	self assert: (link22 previousLink = link21).
	
	self assert: (link23 nextLink = link21).
	self assert: (link23 previousLink = link22).
		
	self assert: (candidates head = link21).
	self assert: (candidates tail = link23).
	
	self assert: ((category1 headLink) = nil).
	self assert: ((category1 tailLink) = nil).
	
	self assert: ((category2 headLink) = link21).
	self assert: ((category2 tailLink) = link23).
	
	self assert: ((category3 headLink) = nil).
	self assert: ((category3 tailLink) = nil).
]

{ #category : #'as yet unclassified' }
GTSpotterCandidatesListTest >> testRemoveCandidatesA1FromA1A2A3 [
	|link21 link22 link23 link31 link32 link33 category1 category2 category3|
	
	category1 := candidates addProcessor: A1.
	category2 := candidates addProcessor: A2.
	category3 := candidates addProcessor: A3.
	
	candidates addCandidate: 11 in: A1.
	candidates addCandidate: 12 in: A1.
	candidates addCandidate: 13 in: A1.
	link21 := candidates addCandidate: 21 in: A2.
	link22 := candidates addCandidate: 22 in: A2.
	link23 := candidates addCandidate: 23 in: A2.
	link31 := candidates addCandidate: 31 in: A3.
	link32 := candidates addCandidate: 32 in: A3.
	link33 := candidates addCandidate: 33 in: A3.
	
	candidates removeAllCandidatesOf: A1.
	
	self assert: (link21 nextLink = link22).
	self assert: (link21 previousLink = link33).
	
	self assert: (link22 nextLink = link23).
	self assert: (link22 previousLink = link21).
	
	self assert: (link23 nextLink = link31).
	self assert: (link23 previousLink = link22).
	
	self assert: (link31 nextLink = link32).
	self assert: (link31 previousLink = link23).
	
	self assert: (link32 nextLink = link33).
	self assert: (link32 previousLink = link31).
	
	self assert: (link33 nextLink = link21).
	self assert: (link33 previousLink = link32).
		
	self assert: (candidates head = link21).
	self assert: (candidates tail = link33).
	
	self assert: ((category1 headLink) = nil).
	self assert: ((category1 tailLink) = nil).
	
	self assert: ((category2 headLink) = link21).
	self assert: ((category2 tailLink) = link23).
	
	self assert: ((category3 headLink) = link31).
	self assert: ((category3 tailLink) = link33).
]
