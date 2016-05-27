// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.springsource.petclinic.repository;

import com.mysema.query.BooleanBuilder;
import com.mysema.query.jpa.JPQLQuery;
import com.mysema.query.types.Order;
import com.mysema.query.types.OrderSpecifier;
import com.mysema.query.types.path.NumberPath;
import com.springsource.petclinic.domain.Owner;
import com.springsource.petclinic.domain.QOwner;
import com.springsource.petclinic.repository.GlobalSearch;
import com.springsource.petclinic.repository.OwnerRepositoryCustom;
import com.springsource.petclinic.repository.OwnerRepositoryImpl;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.transaction.annotation.Transactional;

privileged aspect OwnerRepositoryImpl_Roo_Jpa_Repository_Impl {
    
    declare parents: OwnerRepositoryImpl implements OwnerRepositoryCustom;
    
    declare @type: OwnerRepositoryImpl: @Transactional(readOnly = true);
    
    public Page<Owner> OwnerRepositoryImpl.findAll(GlobalSearch globalSearch, Pageable pageable) {
        NumberPath<Long> idOwner = new NumberPath<Long>(Long.class, "id");
        QOwner owner = QOwner.owner;
        JPQLQuery query = getQueryFrom(owner);
        BooleanBuilder where = new BooleanBuilder();

        if (globalSearch != null) {
            String txt = globalSearch.getText();
            where.and(
                owner.firstName.containsIgnoreCase(txt)
                .or(owner.lastName.containsIgnoreCase(txt))
                .or(owner.address.containsIgnoreCase(txt))
                .or(owner.city.containsIgnoreCase(txt))
                .or(owner.telephone.containsIgnoreCase(txt))
            );

        }
        query.where(where);

        long totalFound = query.count();
        if (pageable != null) {
            if (pageable.getSort() != null) {
                for (Sort.Order order : pageable.getSort()) {
                    Order direction = order.isAscending() ? Order.ASC : Order.DESC;

                    switch(order.getProperty()){
                        case "firstName":
                           query.orderBy(new OrderSpecifier<String>(direction, owner.firstName));
                           break;
                        case "lastName":
                           query.orderBy(new OrderSpecifier<String>(direction, owner.lastName));
                           break;
                        case "address":
                           query.orderBy(new OrderSpecifier<String>(direction, owner.address));
                           break;
                        case "city":
                           query.orderBy(new OrderSpecifier<String>(direction, owner.city));
                           break;
                        case "telephone":
                           query.orderBy(new OrderSpecifier<String>(direction, owner.telephone));
                           break;
                    }
                }
            }
            query.offset(pageable.getOffset()).limit(pageable.getPageSize());
        }
        query.orderBy(idOwner.asc());
        
        List<Owner> results = query.list(owner);
        return new PageImpl<Owner>(results, pageable, totalFound);
    }
    
}