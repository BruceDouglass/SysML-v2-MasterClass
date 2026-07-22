package MetadaDataExamplePkg {
    public import ScalarValues::*;
    enum def RequirementStatus {
        NONE;
        CREATED;
        ACCEPTED;
        REJECTED;
        REVIEWED;
        DESIGNED;
        IMPLEMENTED;
        VERIFIED;
        DEPLOYED;
    }
    metadata def RequirementInfo {
        attribute status : RequirementStatus = status::NONE;
        attribute author : String;
    }
    requirement r1 {
        doc /* this is a requirement */
        @reqInfo : RequirementInfo {
            status = status::ACCEPTED;
            author = "Bruce Douglass";
        }
    }
    requirement r2 {
        doc /* this is another requirement */
        @RequirementInfo {
            status = status::REJECTED;
            author = "Sam Owens";
        }
    }
}
view 'Metadata view' : DS_Views::SymbolicViews::gv;
