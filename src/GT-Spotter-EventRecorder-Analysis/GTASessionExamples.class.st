Class {
	#name : #GTASessionExamples,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #running }
GTASessionExamples class >> session1 [
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
