CREATE TABLE leads_master (
    lead_id VARCHAR(10) PRIMARY KEY,
    company_id VARCHAR(10),
    company_name VARCHAR(255),
    job_requirement VARCHAR(255),
    tech_stack TEXT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    designation VARCHAR(255),
    contact_email VARCHAR(255),
    contact_linkedin TEXT,
    contact_number VARCHAR(50),
    city VARCHAR(100),
    country VARCHAR(100),
    lead_source VARCHAR(100)
);


CREATE TABLE outreach_activity (
    activity_id VARCHAR(10) PRIMARY KEY,
    lead_id VARCHAR(10),
    channel VARCHAR(50),
    attempt_number INT,
    activity_date DATE,
    activity_hour INT,
    response_received VARCHAR(10),
    response_type VARCHAR(50),
    meeting_booked VARCHAR(10),
    FOREIGN KEY (lead_id) REFERENCES leads_master(lead_id)
);

SELECT * FROM meetings;

CREATE TABLE meetings (
    meeting_id VARCHAR(10) PRIMARY KEY,
    lead_id VARCHAR(10),
    meeting_date DATE,
    channel_origin VARCHAR(50),
    meeting_outcome VARCHAR(50),
    FOREIGN KEY (lead_id) REFERENCES leads_master(lead_id)
);

DROP TABLE IF EXISTS opportunity_outcomes;

CREATE TABLE opportunity_outcomes (
    opportunity_id VARCHAR(10) PRIMARY KEY,
    lead_id VARCHAR(10),
    intro_meeting_done VARCHAR(10),
    intro_meeting_date DATE,
    interview_scheduled VARCHAR(10),
    final_outcome VARCHAR(50),
    outcome_reason VARCHAR(255),
    channel_origin VARCHAR(50),
    FOREIGN KEY (lead_id) REFERENCES leads_master(lead_id)
);

SELECT * FROM opportunity_outcomes;

CREATE TABLE lead_funnel_status (
    lead_id VARCHAR(10) PRIMARY KEY,
    contacted VARCHAR(10),
    responded VARCHAR(10),
    meeting_booked VARCHAR(10),
    opportunity_created VARCHAR(10),
    final_stage VARCHAR(50),
    FOREIGN KEY (lead_id) REFERENCES leads_master(lead_id)
);