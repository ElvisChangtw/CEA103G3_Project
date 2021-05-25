package com.authority.model;

import java.util.List;

public interface AuthorityDAO_interface {
          public void insert(AuthorityVO authorityVO);
          public void update(AuthorityVO authorityVO);
          public void delete(Integer empno ,Integer function_no);
          public List<AuthorityVO> findByEmpNo(Integer empno);
          public AuthorityVO findByEmpNo_FunctionNo(Integer empno, Integer function_no);
          public List<AuthorityVO> getAllByEmpNo();
}