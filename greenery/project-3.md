1a) What is our overall conversion rate?

Answer: 62.46%

SQL: 
select round(((count(distinct case when checkouts > 0 then session_id end) / count(distinct session_id)) * 100.00),2) as conversion_rates 
from dev_db.dbt_sanr82gmailcom.fact_page_views;

1b) What is our conversion rate by product?

Answer:
PRODUCT_ID	                            PRODUCT_NAME	        CONVERSION_RATES
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80	String of pearls	       60.94
74aeb414-e3dd-4e8a-beef-0fa45225214d	Arrow Head	            55.56
5b50b820-1d0a-4231-9422-75e7f6b0cecf	Pilea Peperomioides	       47.46
579f4cd0-1f45-49d2-af55-9ab2b72c3b35	Rubber Plant	            51.85
c17e63f7-0d28-4a95-8248-b01ea354840e	Cactus	                 54.55
d3e228db-8ca5-42ad-bb0a-2148e876cc59	Money Tree	            46.43
615695d3-8ffd-4850-bcf7-944cf6d3685b	Aloe Vera	                 49.23
58b575f2-2192-4a53-9d21-df9a0c14fc25	Angel Wings Begonia	       39.34
bb19d194-e1bd-4358-819e-cd1f1b401c0c	Birds Nest Fern	       42.31
e2e78dfc-f25c-4fec-a002-8e280d61a2f2	Boston Fern	            41.27
be49171b-9f72-4fc9-bf7a-9a52e259836b	Monstera	                 51.02
689fb64e-a4a2-45c5-b9f2-480c2155624d	Bamboo	                 53.73
b86ae24b-6f59-47e8-8adc-b17d88cbd367	Calathea Makoyana	       50.94
c7050c3b-a898-424d-8d98-ab0aaad7bef4	Orchid	                 45.33
e18f33a6-b89a-4fbc-82ad-ccba5bb261cc	Ponytail Palm	            40
80eda933-749d-4fc6-91d5-613d29eb126f	Pink Anthurium	            41.89
b66a7143-c18a-43bb-b5dc-06bb5d1d3160	ZZ Plant	                 53.97
a88a23ef-679c-4743-b151-dc7722040d8c	Jade Plant	            47.83
e8b6528e-a830-4d03-a027-473b411c7f02	Snake Plant	            39.73
55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3	Philodendron	            48.39
843b6553-dc6a-4fc4-bceb-02cd39af0168	Ficus	                 42.65
35550082-a52d-4301-8f06-05b30f6f3616	Devil's Ivy	            48.89
4cda01b9-62e2-46c5-830f-b7f262a58fb1	Pothos	                 34.43
37e0062f-bd15-4c3e-b272-558a86d90598	Dragon Tree	            46.77
e5ee99b6-519f-4218-8b41-62f48f59f700	Peace Lily	            40.91
6f3a3072-a24d-4d11-9cef-25b0b5f8a4af	Alocasia Polly	            41.18
05df0866-1a66-41d8-9ed7-e2bbcddd6a3d	Bird of Paradise	       45
64d39754-03e4-4fa0-b1ea-5f4293315f67	Spider Plant	            47.46
e706ab70-b396-4d30-a6b2-a1ccf3625b52	Fiddle Leaf Fig	       50
5ceddd13-cf00-481f-9285-8340ab95d06d	Majesty Palm	            49.25

SQL:
select f.product_id, 
       product_name,
       round(((count(distinct case when checkouts > 0 then session_id end) / count(distinct session_id)) * 100.00),2) as conversion_rates
from dev_db.dbt_sanr82gmailcom.fact_page_views f 
     left join dev_db.dbt_sanr82gmailcom.stg_postgres__products d on f.product_id = d.product_guid
group by 1, 2;