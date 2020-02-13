package com.keji09.erp.utils;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.zip.ZipInputStream;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;

import com.dyuproject.protostuff.LinkedBuffer;
import com.dyuproject.protostuff.ProtostuffIOUtil;
import com.dyuproject.protostuff.Schema;
import com.dyuproject.protostuff.runtime.RuntimeSchema;

public class FileUtil {
	private static Log log = LogFactory.getLog(FileUtil.class);
	
	/**
	 * 根据日期给文件排序，
	 * @param list
	 * @param desc true为倒序(最新日期在前面)，false正序
	 */
	public static void sortByDate(List<File> list,final boolean desc) {
		Collections.sort(list, new Comparator<File>() {
			public int compare(File o1, File o2) {
				Long a = o1.lastModified();
				Long b = o2.lastModified();
				int sort = 0;
				if(desc) {
					sort = b.compareTo(a);
				}else {
					sort = a.compareTo(b);
				}
				return sort;
			}
		});
	}

	/**
	 * 写文件
	 * 
	 * @param f
	 * @param content
	 */
	public static void writeFile(File f, String content) {
		writeFile(f, content, "utf-8");
	}

	/**
	 * 写文件
	 * 
	 * @param f
	 * @param content
	 */
	public static void writeFile(File f, String content, String encode) {
		try {
			// 如果目录不存在，创建目录
			File parent = new File(f.getParent());
			parent.mkdirs();

			if (!f.exists()) {
				f.createNewFile();
			}
			OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream(f), encode);
			BufferedWriter utput = new BufferedWriter(osw);
			FileOutputStream fo = null;
			try {
				fo = new FileOutputStream(f);
				osw = new OutputStreamWriter(fo, encode);
				utput = new BufferedWriter(osw);
				utput.write(content);
				utput.flush();
			} catch (IOException ioException) {
				ioException.printStackTrace();
			} finally {
				try {
					if (fo != null) {
						fo.close();
					}
					if (utput != null) {
						utput.close();
					}
					if (osw != null) {
						osw.close();
					}
				} catch (IOException e) {
					log.error(e.getMessage(), e);
				}
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}

	/**
	 * 写出url内容为文件
	 * @param f 写出的文件
	 * @param url 写出的内容
	 */
	public static void writeFileByUrl(String file, String url) {
		byte[] bytes = null;
		InputStream in = null;
		ByteArrayOutputStream bos = null;
		
		try {
			URL resourceUrl = new URL(url);
			in = (InputStream) resourceUrl.getContent();
			
			bos = new ByteArrayOutputStream();
			byte[] b = new byte[1024];
			int n;
			while ((n = in.read(b)) != -1) {
				bos.write(b, 0, n);
			}
			
			bytes = bos.toByteArray();
			
			File f = new File(file);
			
			writeFile(f, bytes);
			
		} catch (IOException e) {
			log.error(e.getMessage(),e);
		} finally {
			try {
				if (in != null) {
					in.close();
				}
				if (bos != null) {
					bos.close();
				}
			} catch (IOException e) {
				log.error(e.getMessage(), e);
			}
		}
	}

	/**
	 * 写文件
	 * 
	 * @param f
	 * @param content
	 */
	public static void writeFile(File f, byte[] bytes) {
		try {
			// 如果目录不存在，创建目录
			File parent = new File(f.getParent());
			parent.mkdirs();

			if (!f.exists()) {
				f.createNewFile();
			}

			BufferedOutputStream bos = null;
			FileOutputStream fo = null;
			try {
				fo = new FileOutputStream(f);
				bos = new BufferedOutputStream(fo);
				bos.write(bytes);
				bos.flush();
			} catch (IOException ioException) {
				ioException.printStackTrace();
			} finally {
				try {
					if (fo != null) {
						fo.close();
					}
					if (bos != null) {
						bos.close();
					}
				} catch (IOException e) {
					log.error(e.getMessage(), e);
				}
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}

	/**
	 * 写文件
	 * 
	 * @param path
	 * @param content
	 */
	public static void writeFile(String path, String content, String encode) {
		File f = new File(path);
		writeFile(f, content, encode);
	}

	/**
	 * 写文件
	 * 
	 * @param path
	 * @param content
	 */
	public static void writeFile(String path, String content) {
		File f = new File(path);
		writeFile(f, content, "utf-8");
	}

	/**
	 * 读取文件
	 * 
	 * @param file
	 * @return
	 */
	public static String readFile(File file) {
		return readFile(file, "UTF-8");
	}

	/**
	 * 读取文件
	 * 
	 * @param file
	 * @return
	 */
	public static String readFile(File file, String encode) {
		String output = "";
		InputStreamReader isr = null;
		BufferedReader input = null;

		if (file.exists()) {
			if (file.isFile()) {
				try {
					isr = new InputStreamReader(new FileInputStream(file), encode);
					input = new BufferedReader(isr);
					StringBuffer buffer = new StringBuffer();
					String text;
					while ((text = input.readLine()) != null)
						buffer.append(text + "\n");
					output = buffer.toString();

				} catch (IOException ioException) {
					ioException.printStackTrace();
				} finally {
					try {
						if (input != null) {
							input.close();
						}
						if (isr != null) {
							isr.close();
						}
					} catch (IOException e) {
						log.error(e.getMessage(), e);
					}
				}
			} else if (file.isDirectory()) {
				throw new RuntimeException(file.getPath() + " isDirectory！");
			}

		} else {
			throw new RuntimeException(file.getPath() + " Does not exist！");
		}

		return output;
	}

	public static byte[] readFileBytes(File file) {
		byte[] bytes = null;
		FileInputStream fis = null;
		ByteArrayOutputStream bos = null;
		if (file.exists()) {
			if (file.isFile()) {
				try {
					fis = new FileInputStream(file);
					bos = new ByteArrayOutputStream();
					byte[] b = new byte[1024];
					int n;
					while ((n = fis.read(b)) != -1) {
						bos.write(b, 0, n);
					}
					fis.close();
					bos.close();
					bytes = bos.toByteArray();
				} catch (IOException ioException) {
					ioException.printStackTrace();
				} finally {
					try {
						if (fis != null) {
							fis.close();
						}
						if (bos != null) {
							bos.close();
						}
					} catch (IOException e) {
						log.error(e.getMessage(), e);
					}
				}
			} else if (file.isDirectory()) {
				throw new RuntimeException(file.getPath() + " isDirectory！");
			}

		} else {
			throw new RuntimeException(file.getPath() + " Does not exist！");
		}

		return bytes;
	}

	/**
	 * 读取文件
	 * 
	 * @param fileName
	 * @return
	 */
	public static String readFile(String fileName, String encode) {
		File file = new File(fileName);
		return readFile(file, encode);
	}

	/**
	 * 读取文件
	 * 
	 * @param fileName
	 * @return
	 */
	public static String readFile(String fileName) {
		return readFile(fileName, "utf-8");
	}

	/**
	 * 获取目录下所有文件，一级
	 * 
	 * @param folder
	 * @return
	 */
	public static List<File> getFiles(String folder) {
		return getFiles(folder, null);
	}

	/**
	 * 获取目录下所有文件，一级，后缀区分
	 * 
	 * @param folder
	 * @return
	 */
	public static List<File> getFiles(String folder, String suffix) {
		File file = new File(folder);
		List<File> list = new ArrayList<File>();
		if (file.exists() && file.isDirectory()) {
			File[] files = file.listFiles();
			for (File f : files) {
				String fileName = f.getName();
				if (suffix == null) {
					list.add(f);
				} else if (fileName.endsWith(suffix)) {
					list.add(f);
				}
			}
		}
		return list;
	}

	/**
	 * 遍历所有文件夹，取出文件
	 */
	public static List<File> getFileDeeps(String folder, String suffix) {
		File file = new File(folder);
		List<File> list = new ArrayList<File>();
		if (file.exists() && file.isDirectory()) {
			File[] files = file.listFiles();

			for (File f : files) {
				if (f.isFile()) {
					String fileName = f.getName();
					if (suffix == null) {
						list.add(f);
					} else if (fileName.endsWith(suffix)) {
						list.add(f);
					}
				} else if (f.isDirectory()) {
					list.addAll(getFileDeeps(f.getAbsolutePath(), suffix));
				}
			}
		}
		return list;
	}

	/**
	 * 遍历所有文件夹，取出文件
	 */
	public static List<File> getFileDeeps(String folder, List<String> suffixs) {
		File file = new File(folder);
		List<File> list = new ArrayList<File>();
		if (file.exists() && file.isDirectory()) {
			File[] files = file.listFiles();

			for (File f : files) {
				if (f.isFile()) {
					String fileName = f.getName();
					for (String suffix : suffixs) {
						if (suffix == null) {
							list.add(f);
						} else if (fileName.toLowerCase().endsWith(suffix)) {
							list.add(f);
						}
					}
				} else if (f.isDirectory()) {
					list.addAll(getFileDeeps(f.getAbsolutePath(), suffixs));
				}
			}
		}
		return list;
	}

	/**
	 * 获取目录下所有文件夹，一级
	 * 
	 * @param folder
	 * @return
	 */
	public static List<File> getFolders(String folder) {
		File file = new File(folder);
		List<File> files = new ArrayList<File>();
		if (file.exists()) {
			File[] sonFiles = file.listFiles();
			if (sonFiles != null && sonFiles.length > 0) {
				for (int i = 0; i < sonFiles.length; i++) {
					if (sonFiles[i].isDirectory()) {
						files.add(sonFiles[i]);
					}
				}
			}
		}
		return files;
	}

	/**
	 * 判断是否有子目录
	 * 
	 * @param folder
	 * @return
	 */
	public static boolean hasSonFolder(String folder) {
		File file = new File(folder);
		return hasSonFolder(file);
	}

	/**
	 * 判断是否有子目录
	 * 
	 * @param folder
	 * @return
	 */
	public static boolean hasSonFolder(File file) {
		if (file.exists()) {
			File[] sonFiles = file.listFiles();
			if (sonFiles != null && sonFiles.length > 0) {
				for (int i = 0; i < sonFiles.length; i++) {
					if (sonFiles[i].isDirectory()) {
						return true;
					}
				}
			}
		}
		return false;
	}

	/**
	 * 创建目录
	 * 
	 * @param folder
	 */
	public static void mkdirs(String folder) {
		File file = new File(folder);
		if (!file.exists()) {
			file.mkdirs();
		}
	}

	public static String writeFileByUrl(String url) {
		String result = null;
		byte[] bytes = null;
		InputStream in = null;
		ByteArrayOutputStream bos = null;
		
		try {
			URL resourceUrl = new URL(url);
			in = (InputStream) resourceUrl.getContent();
			
			bos = new ByteArrayOutputStream();
			byte[] b = new byte[1024];
			int n;
			while ((n = in.read(b)) != -1) {
				bos.write(b, 0, n);
			}
			
			bytes = bos.toByteArray();
			
			result = new String(bytes);
			
		} catch (IOException e) {
			log.error(e.getMessage(),e);
		} finally {
			try {
				if (in != null) {
					in.close();
				}
				if (bos != null) {
					bos.close();
				}
			} catch (IOException e) {
				log.error(e.getMessage(), e);
			}
		}
		return result;
	}
	/**
	 * 复制文件
	 * 
	 * @param src
	 * @param dst
	 */
	public static void copy(File src, File dst) {
		try {
			// 如果是文件夹，并且已存在则什么都不做
			if (dst.isDirectory() && dst.exists()) {
				return;
			}
			if (!dst.getParentFile().exists()) {
				dst.getParentFile().mkdirs();
			}

			int BUFFER_SIZE = 32 * 1024;
			InputStream in = null;
			OutputStream out = null;
			try {
				in = new FileInputStream(src);
				out = new FileOutputStream(dst);
				byte[] buffer = new byte[BUFFER_SIZE];
				int count;
				while ((count = in.read(buffer)) != -1) {
					out.write(buffer, 0, count);
				}
				out.flush();
			} catch (Exception e) {
				log.error(src.getAbsolutePath() + "," + dst.getAbsolutePath() + ";" + e.getMessage(), e);
			} finally {
				if (null != in) {
					in.close();
				}
				if (null != out) {
					out.close();
				}
			}
		} catch (Exception e2) {
			log.error(e2.getMessage(), e2);
		}
	}

	/**
	 * 复制文件夹，包含内容，如果已有覆盖已有文件
	 * 
	 * @param overwrite
	 *            是否覆盖文件
	 */
	public static void copyDirectiory(String sourceDir, String targetDir, boolean overwrite) throws IOException {
		if (new File(sourceDir).exists()) {
			// 新建目标目录
			File targetFolder = new File(targetDir);
			if (!targetFolder.exists()) {
				targetFolder.mkdirs();
			}
			// 获取源文件夹当前下的文件或目录
			File[] file = (new File(sourceDir)).listFiles();
			for (int i = 0; i < file.length; i++) {

				try {
					if (file[i].isFile()) {
						// 源文件
						File sourceFile = file[i];
						// 目标文件
						File targetFile = new File(new File(targetDir).getAbsolutePath() + File.separator + file[i].getName());

						// 如果重写为true，直接覆盖现有文件
						if (overwrite) {
							copy(sourceFile, targetFile);
						} else if (!targetFile.exists()) {
							// 如果文件不存在才写文件
							copy(sourceFile, targetFile);
						}

					}
					if (file[i].isDirectory()) {
						// 准备复制的源文件夹
						String dir1 = sourceDir + "/" + file[i].getName();
						// 准备复制的目标文件夹
						String dir2 = targetDir + "/" + file[i].getName();
						File fileDir2 = new File(targetDir);
						if (!fileDir2.exists()) {
							fileDir2.mkdirs();
						}
						copyDirectiory(dir1, dir2, overwrite);
					}
				} catch (Exception e) {
					log.error(e.getMessage(), e);
				}

			}
		}
	}

	/**
	 * 获取扩展名 .jpg
	 */
	public static String getExt(File src) {
		if (src != null && src.getName().contains(".")) {
			String name = src.getName();
			return name.substring(name.lastIndexOf("."), name.length());
		}
		return "";
	}

	/**
	 * 获取扩展名 .jpg
	 */
	public static String getExt(String src) {
		if (src != null && src.contains(".")) {
			return src.substring(src.lastIndexOf("."), src.length());
		}
		return "";
	}

	/**
	 * 删除指定文件
	 * 
	 * @param path
	 */
	public static void del(String path) {
		File file = new File(path);
		deleteFile(file);
	}

	/**
	 * 递归删除文件夹下所有文件
	 * 
	 * @param file
	 */
	public static void deleteFile(File file) {
		if (file.exists() && file.canRead()) { // 判断文件是否存在
			try {
				if (file.isFile()) { // 判断是否是文件
					file.delete(); // delete()方法 你应该知道 是删除的意思;
				} else if (file.isDirectory()) { // 否则如果它是一个目录
					File files[] = file.listFiles(); // 声明目录下所有的文件 files[];
					for (int i = 0; i < files.length; i++) { // 遍历目录下所有的文件
						deleteFile(files[i]); // 把每个文件 用这个方法进行迭代
					}
				}
				file.delete();
			} catch (Exception e) {
				log.error(e.getMessage(), e);
			}
		}
	}

	public static void deleteFile(List<File> files) {
		for (File f : files) {
			deleteFile(f);
		}
	}

	/**
	 * 序列化对象
	 */
	public static <T> byte[] serializeObjectList(List<T> list) {
		if (list == null || list.size() <= 0) {
			return null;
		}

		@SuppressWarnings("unchecked")
		Schema<T> schema = (Schema<T>) RuntimeSchema.getSchema(list.get(0).getClass());
		LinkedBuffer buffer = LinkedBuffer.allocate(1024 * 1024);
		byte[] protostuff = null;
		ByteArrayOutputStream bos = null;
		try {
			bos = new ByteArrayOutputStream();
			ProtostuffIOUtil.writeListTo(bos, list, schema, buffer);
			protostuff = bos.toByteArray();
		} catch (Exception e) {
			throw new RuntimeException("序列化对象列表(" + list + ")发生异常!", e);
		} finally {
			buffer.clear();
			try {
				if (bos != null) {
					bos.close();
				}
			} catch (IOException e) {
				log.error(e.getMessage(), e);
			}
		}

		return protostuff;
	}

	/**
	 * 反序列化对象
	 */
	public static <T> List<T> deserializeObjectList(byte[] bytesList, Class<T> targetClass) {
		if (bytesList == null || bytesList.length <= 0) {
			return null;
		}
		Schema<T> schema = RuntimeSchema.getSchema(targetClass);
		List<T> list = new ArrayList<T>();
		try {
			list = ProtostuffIOUtil.parseListFrom(new ByteArrayInputStream(bytesList), schema);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return list;
	}

	/**
	 * 压缩文件列表到某ZIP文件
	 * 
	 * @param zipFilename
	 *            要压缩到的ZIP文件
	 * @param paths
	 *            文件列表，多参数
	 * @throws Exception
	 */
	public static void zip(String zipFilename, List<File> files) {
		try {
			compress(new FileOutputStream(zipFilename), files);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}

	/**
	 * 解压缩
	 * 
	 * @param sZipPathFile
	 *            要解压的文件
	 * @param sDestPath
	 *            解压到某文件夹
	 * @return
	 */
	public static List<String> unzip(String sZipPathFile, String sDestPath) {
		List<String> allFileName = new ArrayList<String>();
		try {
			// 先指定压缩档的位置和档名，建立FileInputStream对象
			FileInputStream fins = new FileInputStream(sZipPathFile);
			// 将fins传入ZipInputStream中
			ZipInputStream zins = new ZipInputStream(fins);
			java.util.zip.ZipEntry ze = null;
			byte[] ch = new byte[256];
			while ((ze = zins.getNextEntry()) != null) {
				File zfile = new File(sDestPath + ze.getName());
				File fpath = new File(zfile.getParentFile().getPath());
				if (ze.isDirectory()) {
					if (!zfile.exists())
						zfile.mkdirs();
					zins.closeEntry();
				} else {
					if (!fpath.exists())
						fpath.mkdirs();
					FileOutputStream fouts = new FileOutputStream(zfile);
					int i;
					allFileName.add(zfile.getAbsolutePath());
					while ((i = zins.read(ch)) != -1)
						fouts.write(ch, 0, i);
					zins.closeEntry();
					fouts.close();
				}
			}
			fins.close();
			zins.close();
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return allFileName;
	}

	private static void compress(OutputStream os, List<File> files) throws Exception {
		ZipOutputStream zos = new ZipOutputStream(os);
		for (File file : files) {
			if (file.exists()) {
				if (file.isDirectory()) {
					zipDirectory(zos, file.getPath(), file.getName() + File.separator);
				} else {
					zipFile(zos, file.getPath(), "");
				}
			}
		}
		zos.close();
	}

	private static void zipFile(ZipOutputStream zos, String filename, String basePath) throws Exception {
		File file = new File(filename);
		if (file.exists()) {
			FileInputStream fis = new FileInputStream(filename);
			ZipEntry ze = new ZipEntry(basePath + file.getName());
			zos.putNextEntry(ze);
			byte[] buffer = new byte[8192];
			int count = 0;
			while ((count = fis.read(buffer)) > 0) {
				zos.write(buffer, 0, count);
			}
			fis.close();
		}
	}

	private static void zipDirectory(ZipOutputStream zos, String dirName, String basePath) throws Exception {
		zos.setEncoding("UTF-8");
		File dir = new File(dirName);
		if (dir.exists()) {
			File files[] = dir.listFiles();
			if (files.length > 0) {
				for (File file : files) {
					if (file.isDirectory()) {
						zipDirectory(zos, file.getPath(), basePath + file.getName().substring(file.getName().lastIndexOf(File.separator) + 1) + File.separator);
					} else
						zipFile(zos, file.getPath(), basePath);
				}
			} else {
				ZipEntry ze = new ZipEntry(basePath);
				zos.putNextEntry(ze);
			}
		}
	}
	
	public static void test() {
		File f = new File("");
	}

	public static void main(String[] args) throws Exception {

		long start = System.currentTimeMillis();

		// zip("D://aaa.zip", "D:/aaa","D:/bbb");

		// unzip("D:/aaa.zip", "D:/");

		long end = System.currentTimeMillis();
		System.out.println(end - start);
		System.out.println((end - start) / 1000);
	}
}
