public class contacthelper {

    public static void dupcontact(list<contact>contactlist){
           set<string>newmails=new set<string>();
        for(contact con:contactlist){
            newmails.add(con.email);
    }
        if (newmails.isempty()){
            return;
        }
list<contact>duplicatemails=[select id,email from contact where email IN:newmails];
set<string>existingmails=new set<string>();
      for(contact con:duplicatemails){
          existingmails.add(con.email);
}
      for (contact con :contactlist){
          if (existingmails.contains(con.email)){
                con.adderror('duplicate email');
}
}
}
}