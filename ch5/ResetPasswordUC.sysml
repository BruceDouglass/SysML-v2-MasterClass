package ResetPasswordUC {
    public import ScalarValues::*;
    use case ResetPasswordUC {
        action ResetPasswordActivity {
            attribute password : String;
            attribute passwordTooShort : Boolean;
            attribute passwordRulesCheckFail : Boolean;
            attribute passwordReusedFail : Boolean;
            /* actions */
            action 'Display passwword too short message';
            action 'Check password content rules';
            action 'Display password changed message';
            action 'Prompt User for password';
            action 'Display password not matching content rules message';
            action 'Check password reuse rules';
            action 'Display password reuse error message';
            action 'Store old password';
            action 'Update user password';
            /* control nodes */
            decide d1;
            decide d2;
            decide d3;
            merge m1;
            merge m2;
            /* action flow */
            first start then m1;
            action 'Check password length';
            first m1 then 'Prompt User for password';
            first 'Prompt User for password' then 'Check password length';
            first 'Check password length' then d1;
            first d1 if passwordTooShort then 'Display passwword too short message';
            first d1 if not passwordTooShort then 'Check password content rules';
            first 'Check password content rules' then d2;
            first d2 if passwordRulesCheckFail then 'Display password not matching content rules message';
            first 'Display password not matching content rules message' then m2;
            first m2 then m1;
            first d2 if not passwordRulesCheckFail then 'Check password reuse rules';
            first 'Check password reuse rules' then d3;
            first d3 if passwordReusedFail then 'Display password reuse error message';
            first 'Display passwword too short message' then m1;
            first d3 if not passwordReusedFail then 'Store old password';
            first 'Store old password' then 'Update user password';
            first 'Update user password' then 'Display password changed message';
            first 'Display password changed message' then done;
            first 'Display password reuse error message' then m2;
        }
    }
}
view 'RestPasswordUC View' : DS_Views::SymbolicViews::gv;
