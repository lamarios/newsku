-- an OIDC subject can only be linked to one account. Duplicates could only come from users setting
-- it themselves, so we unlink them all, the rightful owner will be linked again on next OIDC login
update users
set oidc_sub = null
where oidc_sub in (select oidc_sub
                   from users
                   where oidc_sub is not null
                   group by oidc_sub
                   having count(*) > 1);

create unique index oidc_sub_idx on users (oidc_sub);
