package com.disid.restful.repository;

import com.disid.restful.model.Category;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional(readOnly = true)
public interface CategoryRepository
    extends JpaRepository<Category, Long>, CategoryRepositoryCustom {

}
