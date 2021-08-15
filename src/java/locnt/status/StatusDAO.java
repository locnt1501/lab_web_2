/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.status;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import locnt.dtos.CategoryDTO;
import locnt.dtos.StatusDTO;
import locnt.utils.DBUtils;

/**
 *
 * @author LocPC
 */
public class StatusDAO implements Serializable {

    private List<StatusDTO> listStatus;

    public List<StatusDTO> getListStatus() {
        return listStatus;
    }
    

    public void getAllStatus() throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnect();
            if (con != null) {
                String sql = "Select StatusId, Name FROM Status";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int status = rs.getInt("StatusId");
                    String name = rs.getString("Name");
                    StatusDTO dto = new StatusDTO(status, name);
                    if (this.listStatus == null) {
                        this.listStatus = new ArrayList<>();
                    }
                    this.listStatus.add(dto);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}
