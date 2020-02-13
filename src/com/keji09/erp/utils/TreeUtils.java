package com.keji09.erp.utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.keji09.erp.bean.BaseTree;



/**
 * 树形控件Util
 */
public class TreeUtils {
	
	/**
	 * 只有parentId是null，才是根节点
	 * @param list list必须是BaseTree子类
	 */
	public static <T> List<?> buildTree(List<?> list) {
		@SuppressWarnings("unchecked")
		List<BaseTree> tempTree = (List<BaseTree>) CommonUtil.transList(list);
		List<BaseTree> tree = initTree(tempTree);
		return tree;
	}
	
	/**
	 * 会去重复。只要是getParent，在队列里面没有的，都认为是根节点
	 * @param list list必须是BaseTree子类
	 */
	public static <T> List<?> buildTree2(List<?> list) {
		@SuppressWarnings("unchecked")
		List<BaseTree> tempTree = (List<BaseTree>) CommonUtil.transList(list);
		List<BaseTree> tree = initTree2(tempTree);
		return tree;
	}
	
	
	public static List<BaseTree> initTree2(List<BaseTree> tempTree) {
		List<BaseTree> result = new ArrayList<BaseTree>();
		Map<String,BaseTree> map = new HashMap<String, BaseTree>();
		
		//排序
		sort(result);
		
		//去重复，填充map
		for(int i = 0; i < tempTree.size(); i++) {
			BaseTree bt = tempTree.get(i);
			if(!map.containsKey(bt.getId())) {
				map.put(bt.getId(), bt);
			}else {
				tempTree.remove(i--);
			}
		}
		
		//设置子节点
		for(int i = 0; i < tempTree.size(); i++) {
			BaseTree temp = tempTree.get(i);
			String parentId = temp.getParentId();
			BaseTree parent = map.get(parentId);
			
			//默认false
			temp.setIsParent(false);
			if(parent != null) {
				parent.getChildren().add(temp);
				parent.setIsParent(true);
			}
		}
		
		//获取根节点，返回树
		for(int i = 0; i < tempTree.size(); i++) {
			BaseTree temp = tempTree.get(i);
			//如果没有父节点，认为是根节点
			if(map.get(temp.getParentId()) == null) {
				result.add(temp);
			}
		}
		return result;
	}
	
	/**
	 * 找到所有根节点
	 * @param list 所有树数据
	 */
	public static List<BaseTree> findRootNode(List<BaseTree> list) {
		List<BaseTree> roots = new ArrayList<BaseTree>();
		for(int i = 0;i<list.size();i++) {
			BaseTree bt = list.get(i);
			if(StringUtils.isEmpty(bt.getParentId())) {
				roots.add(bt);
			}
		}
		return roots;
	}
	
	/**
	 * 初始化根节点和子节点
	 * @param list 所有树数据
	 */
	public static List<BaseTree> initTree(List<BaseTree> list) {
		//排序
		sort(list);
		List<BaseTree> roots = findRootNode(list);
		for(int i =0;i<roots.size();i++) {
			initLeaf(roots.get(i), list);
		}
		return roots;
	}
	
	/**
	 * 给当前节点加上子节点
	 * @param node 当前节点
	 * @param list 所有树数据
	 */
	public static void initLeaf(BaseTree node,List<BaseTree> list) {
		for(int i =0;i<list.size();i++) {
			if(node.getId().equals(list.get(i).getParentId())) {
				node.getChildren().add(list.get(i));
				initLeaf(list.get(i),list);
			}
		}
		if(node.getChildren().size() > 0) {
			node.setIsParent(true);
		}else {
			node.setIsParent(false);
		}
	}
	
	public static void sort(List<BaseTree> list) {
		Collections.sort(list, new Comparator<BaseTree>() {
			public int compare(BaseTree o1, BaseTree o2) {
				return o1.getOrder().compareTo(o2.getOrder());
			}
		});
	}
}
