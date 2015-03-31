"
A GTSpotterDiveInLevelCommandTest is a test class for testing the behavior of GTSpotterDiveInLevelCommand
"
Class {
	#name : #GTSpotterSessionAnalysisTest,
	#superclass : #TestCase,
	#instVars : [
		'analysis'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #'as yet unclassified' }
GTSpotterSessionAnalysisTest >> session1 [
	^ GTSpotterSession new
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderContextChangedEvent new;
		add: GTSpotterRecorderSelectedCandidateChangedEvent new;
		add: GTSpotterRecorderCategorySelectedEvent new;
		add: GTSpotterRecorderDiveInCategoryEvent new;
			add: GTSpotterRecorderContextChangedEvent new;
			add: GTSpotterRecorderSelectedCandidateChangedEvent new;
			add: GTSpotterRecorderCategorySelectedEvent new;
			add: GTSpotterRecorderDiveOutEvent new;
		add: GTSpotterRecorderDiveInElementEvent new;
			add: GTSpotterRecorderContextChangedEvent new;
			add: GTSpotterRecorderSelectedCandidateChangedEvent new;
			add: GTSpotterRecorderCategorySelectedEvent new;
			add: GTSpotterRecorderDiveInCategoryEvent new;
				add: GTSpotterRecorderContextChangedEvent new;
				add: GTSpotterRecorderSelectedCandidateChangedEvent new;
				add: GTSpotterRecorderCategorySelectedEvent new;
				add: GTSpotterRecorderDiveOutEvent new;
			add: GTSpotterRecorderContextChangedEvent new;
			add: GTSpotterRecorderSelectedCandidateChangedEvent new;
			add: GTSpotterRecorderCategorySelectedEvent new;
			add: GTSpotterRecorderDiveOutEvent new;
		add: GTSpotterRecorderContextChangedEvent new;
		add: GTSpotterRecorderSelectedCandidateChangedEvent new;
		add: GTSpotterRecorderCategorySelectedEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		yourself
]

{ #category : #'as yet unclassified' }
GTSpotterSessionAnalysisTest >> setUp [
	super setUp.
	analysis := GTSpotterSessionAnalysis new.
	
]

{ #category : #'as yet unclassified' }
GTSpotterSessionAnalysisTest >> testRootsSession1 [
	| roots |
	analysis session: self session1.
	analysis execute.
	roots := analysis session roots.
	self assert: roots size equals: 11.
	self assert: (roots at: 6) children size equals: 4.
	self assert: (roots at: 1) children size equals: 0.
	self assert: (roots at: 7) children size equals: 8.
	self assert: ((roots at: 7) children at: 4) children size equals: 4.

]
