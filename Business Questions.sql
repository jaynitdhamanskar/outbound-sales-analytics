-- Q1. Which lead sources generate the highest number of leads?

SELECT
    lead_source,
    COUNT(*) AS total_leads
FROM leads_master
GROUP BY lead_source
ORDER BY total_leads DESC;

-- Q2. Which lead sources generate meetings?

SELECT * FROM leads_master;
SELECT * FROM meetings;


SELECT
	lm.lead_source,
	COUNT(lm.lead_source) AS no_of_meetings
FROM meetings AS m
LEFT JOIN leads_master AS lm
ON m.lead_id = lm.lead_id
GROUP BY lm.lead_source
ORDER BY COUNT(lm.lead_source) DESC;

-- Q3. Which countries generate the most meetings?

SELECT 
	lm.country, 
	COUNT(m.meeting_id) AS no_of_meetings
FROM
leads_master AS lm
JOIN meetings AS m
ON lm.lead_id = m.lead_id
GROUP BY lm.country
ORDER BY COUNT(m.meeting_id) DESC;


-- Q4. How many outreach attempts are made per channel?

SELECT * FROM leads_master;
SELECT * FROM outreach_activity;

SELECT 
	channel,
	COUNT(*) AS no_of_attempt
FROM outreach_activity
GROUP BY channel
ORDER BY COUNT(*) DESC;

-- Q5. What is the response rate by outreach channel?

SELECT * FROM leads_master;
SELECT * FROM outreach_activity;


SELECT 
	channel,
        COUNT(CASE WHEN response_received = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS response_rate
FROM outreach_activity
GROUP BY channel
ORDER BY response_rate DESC;


-- Q6. What is the meeting conversion rate by outreach channel?

SELECT 
	channel,
	COUNT(CASE WHEN meeting_booked = 'Yes' THEN 1 END) * 100 / COUNT(*) As meeting_conversion_rate
FROM outreach_activity
GROUP BY channel
ORDER BY meeting_conversion_rate DESC;

-- Q7. How many leads exist at each funnel stage?

SELECT 
	final_stage,
    COUNT(*) AS no_of_leads
FROM lead_funnel_status
GROUP BY final_stage
ORDER BY no_of_leads;


-- Q8. What percentage of leads convert from response to meeting?


SELECT
    COUNT(DISTINCT m.lead_id) * 100.0 /
    COUNT(DISTINCT o.lead_id) AS response_to_meeting_rate
FROM outreach_activity o
LEFT JOIN meetings m ON o.lead_id = m.lead_id
WHERE o.response_received = 'Yes';


-- Q9. How long does it take to convert a lead into a meeting?

SELECT
    AVG(m.meeting_date - o.activity_date) AS avg_days_to_meeting
FROM meetings m
JOIN outreach_activity o
ON m.lead_id = o.lead_id
AND o.meeting_booked = 'Yes';


-- Q10. Which job requirements generate the most meetings?

SELECT
    l.job_requirement,
    COUNT(m.meeting_id) AS total_meetings
FROM leads_master l
JOIN meetings m ON l.lead_id = m.lead_id
GROUP BY l.job_requirement
ORDER BY total_meetings DESC;


-- Q11. What is the overall win vs loss distribution?

SELECT
    final_outcome,
    COUNT(*) AS opportunity_count
FROM opportunity_outcomes
GROUP BY final_outcome;

-- Q12. Which outreach channel drives the highest win rate?

SELECT
    channel_origin,
    COUNT(CASE WHEN final_outcome = 'Win' THEN 1 END) * 100.0 / COUNT(*) 
        AS win_rate
FROM opportunity_outcomes
GROUP BY channel_origin
ORDER BY win_rate DESC;


-- Q13. What are the most common reasons for lost opportunities?

SELECT
    outcome_reason,
    COUNT(*) AS lost_count
FROM opportunity_outcomes
WHERE final_outcome = 'Lost'
GROUP BY outcome_reason
ORDER BY lost_count DESC;


-- Q14. Does increasing outreach attempts improve meeting conversion?	

SELECT
    attempt_number,
    COUNT(CASE WHEN meeting_booked = 'Yes' THEN 1 END) * 100.0 / COUNT(*) 
        AS meeting_rate
FROM outreach_activity
GROUP BY attempt_number
ORDER BY attempt_number;


-- Q15. Which follow-up attempt gets the highest response?

SELECT
    channel,
    attempt_number,
    COUNT(CASE WHEN response_received='Yes' THEN 1 END)*100.0/COUNT(*) AS response_rate
FROM outreach_activity
GROUP BY channel, attempt_number
ORDER BY channel, attempt_number;

-- Q16. Are we generating volume or quality?

SELECT
    COUNT(DISTINCT l.lead_id) AS total_leads,
    COUNT(DISTINCT o.lead_id) AS total_wins
FROM leads_master l
LEFT JOIN opportunity_outcomes o
ON l.lead_id = o.lead_id
AND o.final_outcome = 'Win';

