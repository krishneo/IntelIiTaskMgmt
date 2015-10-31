  SELECT *
    FROM (SELECT in_consolidated_tbl.*,
                 (user_bound - assigned_tasks - working_tasks) availablity
            FROM (SELECT login_id,
                         user_role,
                         lower_bound,
                         user_bound,
                         max_bound,
                         (SELECT count(*)
                            FROM raas_tasks
                           WHERE user_name = login_id AND status = 'ASSIGNED')
                            assigned_tasks,
                         (SELECT count(*)
                            FROM raas_tasks
                           WHERE user_name = login_id AND status = 'WORKING')
                            working_tasks,
                         (SELECT count(*)
                            FROM raas_tasks
                           WHERE user_name = login_id AND status = 'FINISHED')
                            finished_tasks
                    FROM raas_users up, raas_group_user_map gum
                   WHERE     user_role != 'MANAGER'
                         AND gum.group_name = 'CPNI'
                         AND up.login_id = gum.user_name) in_consolidated_tbl)
         ou_consolidated_tbl
   WHERE availablity != 0
ORDER BY working_tasks ASC, availablity DESC, assigned_tasks DESC;



SELECT DISTINCT group_name
  FROM raas_tasks tasks, raas_groups grp
 WHERE grp.name = tasks.group_name AND tasks.status = 'UNASSIGNED'
 
 
 update raas_tasks set status='UNASSIGNED',user_name=null where STATUS != 'COMPLETED'